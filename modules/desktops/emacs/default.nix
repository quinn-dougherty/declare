{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    windowManager.exwm = {
      enable = true;
      enableDefaultConfig = true;
      extraPackages = epkgs: with epkgs; [ evil ivy ];
      loadScript = ''
        (evil-mode)
        (ivy-mode)
      '';
      # loadScript = builtins.readFile ./exwm-config.el;
      # (load! "./extras/exwm-config.el")
    };
  };
  imports = [ ./../common-none ];
}
