{ config, lib, pkgs, ... }: {
  hardware.acpilight.enable = true;
  environment.systemPackages = with pkgs; [
    dmenu
    tmate
    # haskellPackages.xmobar # Not needed cuz of the modular/service version
    xcompmgr # possible performance boost
    xorg.xbacklight
    st
    feh
    flameshot
  ];
}
