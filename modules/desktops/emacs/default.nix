{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    windowManager.exwm = {
      enable = true;
      enableDefaultConfig = true;
      extraPackages = epkgs: with epkgs; [ evil ivy ];
      # loadScript = ''
      #   (require 'exwm-systemtray)
      #   (exwm-systemtray-enable)
      #   (require 'exwm-xim)
      #   (exwm-xim-enable)
      #   (evil-mode)
      #   (ivy-mode)
      # '';
    };
  };
  imports = [ ./../common-none ];
}
