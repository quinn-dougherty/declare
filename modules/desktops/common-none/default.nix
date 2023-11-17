{ config, lib, pkgs, ... }: {

  services.picom = {
    enable = true;
    vSync = true;
    inactiveOpacity = 0.8;
  };
  environment.systemPackages = with pkgs; [
    arandr
    dmenu
    tmate
    haskellPackages.xmobar
    # xcompmgr # removal is possible performance boost?
    xorg.xbacklight
    feh
    flameshot
    xscreensaver
    xclip
    dunst # systemd configured in homemanager, but this for on the fly cli

    trayer
    # keyboard
    warpd
  ];
}
