{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;

    # Enable the GNOME Desktop Environment.
    desktopManager.plasma5.enable = true;
    displayManager.sddm.enable = true;
  };
  qt.platformTheme = "kde";
}
