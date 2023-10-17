{ config, lib, pkgs, ... }:

{
  services.xserver.desktopManager.plasma5.mobile = {
    enable = true;
    installRecommendedSoftware = true;
  };
}
