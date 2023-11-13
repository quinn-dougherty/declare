{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    desktopManager.xfce.enable = true;
    displayManager.defaultSession = "xfce";
  };
}
