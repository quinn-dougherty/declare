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
  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };
  environment.systemPackages = with pkgs; [ trayer ];
  programs = {
    evince.enable = true;
    gnome-terminal.enable = true;
  };
}
