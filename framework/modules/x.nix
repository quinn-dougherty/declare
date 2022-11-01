{ config, lib, pkgs, ... }:
with pkgs; {
  environment.systemPackages = [
    dmenu
    tmate
    haskellPackages.xmobar
    xcompmgr
    xscreensaver
    xorg.xbacklight
    st
    feh
    flameshot
  ];
}
