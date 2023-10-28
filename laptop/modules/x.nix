{ config, lib, pkgs, ... }: {
  hardware.acpilight.enable = true;
  environment.systemPackages = with pkgs; [
    arandr
    dmenu
    tmate
    haskellPackages.xmobar
    xcompmgr # removal is possible performance boost?
    xorg.xbacklight
    feh
    flameshot
    xscreensaver
    xclip
    dunst # systemd configured in common/modules/, but this for on the fly cli
    # Extra terminals
    st
    gnome.gnome-terminal
    libsForQt5.konsole
    xterm
    sakura
    xfce.xfce4-terminal
    # plasma5Packages.konsole

    # keyboard
    warpd
  ];
}
