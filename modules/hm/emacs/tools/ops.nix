{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    ix
    sqlite
  ];
}
