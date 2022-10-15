{ pkgs }:
with pkgs; [
  dmenu
  tmate
  # Desktop
  haskellPackages.xmobar
  haskellPackages.xmonad
  haskellPackages.xmonad-contrib
  haskellPackages.xmonad-extras
  xcompmgr
  xscreensaver
  st
  feh
  # clipcat # this is in configuration.nix
  flameshot
  # Notifications
  # dunst # this is in configuration.nix
  # go-upower-notify
]
