{ pkgs, ... }:

{
  # audio stack (NixOS)
  security.rtkit.enable = true;

  services = {
    pulseaudio.enable = false; # do NOT run the PulseAudio daemon

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true; # PipeWire’s PulseAudio compatibility layer
      jack.enable = true;
    };
  };
}
