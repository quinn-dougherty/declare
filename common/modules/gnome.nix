{ config, lib, pkgs, ... }:

{
  services.xserver = {
    enable = true;

    # Enable the GNOME Desktop Environment.
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;

    # Gnome has touchpad support by default, so we skip this.
    # libinput.enable = true;

    # Configure keymap in X11
    layout = "us";
    xkbVariant = "";
  };
}
