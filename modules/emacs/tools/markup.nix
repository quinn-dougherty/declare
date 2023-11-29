{ pkgs, ... }:

with pkgs; [
  emacsPackages.preview-dvisvgm
  texlive.combined.scheme-full
  pandoc
  graphviz
  typst
]
