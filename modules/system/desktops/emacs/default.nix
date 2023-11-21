{ config, lib, pkgs, ... }:

{
  imports = [ ./../greeter.nix ];
  services.xserver = {
    enable = true;
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
