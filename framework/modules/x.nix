{ config, lib, pkgs, ... }:
with pkgs; {
  environment.systemPackages = [
    dmenu
    tmate
    haskellPackages.xmobar
    xcompmgr
    xscreensaver
    st
    feh
    flameshot
  ];
}
