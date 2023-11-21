{ pkgs, ... }:

{
  sound.enable = false;
  hardware.pulseaudio = {
    enable = false;
    package = pkgs.pulseaudioFull;
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    # alsa = {
    #   enable = true;
    #   support32Bit = true;
    # };
    pulse.enable = true;
  };
  environment.systemPackages = [ pkgs.pavucontrol ];
}
