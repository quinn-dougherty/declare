{ config, lib, pkgs, ... }: {
  hardware.acpilight.enable = true;
  environment.systemPackages = with pkgs; [
    dmenu
    tmate
    haskellPackages.xmobar
    xcompmgr # removal is possible performance boost?
    xorg.xbacklight
    st
    feh
    flameshot
    xscreensaver
  ];
}
