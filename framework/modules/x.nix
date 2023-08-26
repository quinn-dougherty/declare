{ config, lib, pkgs, ... }: {
  hardware.acpilight.enable = true;
  environment.systemPackages = with pkgs; [
    dmenu
    tmate
    haskellPackages.xmobar
    xcompmgr # possible performance boost
    xorg.xbacklight
    st
    feh
    flameshot
  ];
}
