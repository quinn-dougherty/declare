{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    emacsPackages.preview-dvisvgm
    texlive.combined.scheme-full
    pandoc
    graphviz
  ];
}
