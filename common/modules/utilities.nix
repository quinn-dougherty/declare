{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    pciutils
    gnumake
    cmake
    patchelf
    unzip
    tree
  ];
}
