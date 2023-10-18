{ config, lib, pkgs, ... }: {
  hardware.acpilight.enable = true;
  environment.systemPackages = with pkgs; [
    dmenu
    tmate
    haskellPackages.xmobar
    xcompmgr # removal is possible performance boost?
    xorg.xbacklight
    feh
    flameshot
    xscreensaver
    # Extra terminals
    st
    gnome.gnome-terminal
    libsForQt5.konsole
    xterm
    sakura
    xfce4-terminal
    # plasma5Packages.konsole
  ];
}
