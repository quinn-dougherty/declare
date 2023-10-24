{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    black
    poetry
    python311Packages.jedi-language-server
  ];
}
