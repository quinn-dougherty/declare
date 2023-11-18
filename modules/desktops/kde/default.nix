{ config, lib, pkgs, ... }:

{
  # imports = [ ./../picom.nix ]
  services.xserver = {
    enable = true;

    desktopManager.plasma5 = {
      enable = true;
      useQtScaling = true;
    };
    displayManager.sddm.enable = true;
  };
  qt.platformTheme = "kde";
}
