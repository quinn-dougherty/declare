{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.lightdm = {
      enable = true;
      greeters.slick = {
        enable = true;
        theme.name = "Adwaita-dark";
        font.name = "Monospace";
      };
    };
    windowManager.exwm = {
      enable = true;
      enableDefaultConfig = true;
      extraPackages = epkgs: with epkgs; [ evil ivy ];
      loadScript = ''
        (require 'exwm-systemtray)
        (exwm-systemtray-enable)
        (evil-mode)
        (ivy-mode)
      '';
    };
  };
  imports = [ ./../common-none ];
}
