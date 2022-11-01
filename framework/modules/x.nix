{ config, lib, pkgs, ... }: {
  hardware.acpilight.enable = true;
  environment.systemPackages = with pkgs; [
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
