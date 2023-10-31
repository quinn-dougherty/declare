{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;

    # Enable the GNOME Desktop Environment.
    desktopManager.plasma.enable = true;
    displayManager.sddm.enable = true;
  };
}
