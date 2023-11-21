{ config, lib, pkgs, ... }:

{
  imports = [ ./../xwayland.nix ];
  services.xserver = {
    enable = true;

    desktopManager.plasma5 = {
      enable = true;
      useQtScaling = true;
    };
    displayManager.sddm.enable = true;
  };
  qt.platformTheme = "kde";
  environment.systemPackages = [ pkgs.libsForQt5.qt5.qtgraphicaleffects ];
}
