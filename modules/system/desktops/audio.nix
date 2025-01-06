{ pkgs, ... }:

{
  # hardware.security.rtkit.enable = true;
  services = {
    pipewire = {
      enable = true;
      audio.enable = true;
      # alsa = {
      #   enable = true;
      #   support32Bit = true;
      # };
      pulse.enable = true;
    };
    pulseaudio = {
      enable = false;
      package = pkgs.pulseaudioFull;
    };
  };
  environment.systemPackages = [ pkgs.pavucontrol ];
}
