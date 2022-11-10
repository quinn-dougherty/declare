{ pkgs, pkgs-stable }:
with pkgs; [
  pass
  pavucontrol

  dropbox-cli
  # maestral
  # maestral-gui

  firefox
  brave
  nyxt
  # Media apps and stuff
  anki
  pkgs-stable.libreoffice
  zotero
  pinta
  obs-studio
  vlc
  pandoc

  # music
  puredata
  qtractor
]
