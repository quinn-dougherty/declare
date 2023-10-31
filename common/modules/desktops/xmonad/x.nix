{ config, lib, pkgs, ... }: {
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

    # keyboard
    warpd
  ];
}
