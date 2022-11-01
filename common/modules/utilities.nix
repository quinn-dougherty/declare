{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    gnumake
    patchelf
    unzip
    tree
  ];
}
