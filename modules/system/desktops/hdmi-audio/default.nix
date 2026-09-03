# HDMI-audio diagnostics.
#
# HDMI audio has an unusually long failure chain (DRM link -> EDID -> ELD ->
# ALSA PCM -> HDA pin -> PipeWire sink -> routing), and every layer fails
# silently in the same way: no sound. This module installs the tools to see
# each layer plus `hdmi-audio-report`, which walks all of them in order.
{ pkgs, lib, ... }:

let
  hdmi-audio-report = pkgs.writeShellApplication {
    name = "hdmi-audio-report";
    # No errexit/nounset: this is a report, a grep that matches nothing must
    # not truncate everything below it.
    bashOptions = [ "pipefail" ];
    runtimeInputs = with pkgs; [
      alsa-utils # aplay, speaker-test, alsamixer
      coreutils
      edid-decode
      gnugrep
      gnused
      inetutils # hostname
      pulseaudio # pactl, against the pipewire-pulse server
      util-linux # dmesg
      wireplumber # wpctl
    ];
    text = builtins.readFile ./report.sh;
  };
in
{
  environment.systemPackages = [
    hdmi-audio-report
  ]
  ++ (with pkgs; [
    alsa-utils
    edid-decode
    read-edid # get-edid, for when the sysfs edid is empty
    drm_info # full connector/mode/property dump
    pavucontrol # per-sink GUI, incl. profile switching
    helvum # live PipeWire graph, shows where a stream is actually landing
    pulseaudio # pactl/pacmd clients (the daemon is not started)
    wireplumber # wpctl
  ]);

  # A TV is not a monitor: it takes hundreds of milliseconds to relock its
  # audio decoder. When WirePlumber suspends an idle HDMI sink, the next sound
  # loses its opening — or the sink comes back on the wrong profile and the TV
  # stays silent. Pin HDMI sinks awake; this is the single most common cause of
  # "audio works, then stops working" on a TV.
  services.pipewire.wireplumber.extraConfig."51-hdmi-no-suspend" = {
    "monitor.alsa.rules" = [
      {
        matches = [
          { "node.name" = "~alsa_output.*hdmi.*"; }
        ];
        actions.update-props = {
          "session.suspend-timeout-seconds" = 0;
        };
      }
    ];
  };

  # dmesg holds the i915/snd_hda hotplug and ELD-read errors that explain most
  # HDMI audio failures, and reading it as the desktop user beats sudo-ing a
  # diagnostic script.
  boot.kernel.sysctl."kernel.dmesg_restrict" = lib.mkDefault 0;
}
