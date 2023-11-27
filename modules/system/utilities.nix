{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    jq
    pciutils
    gnumake
    cmake
    patchelf
    openssl
    zip
    unzip
    ncdu
    tree
    nix-tree
  ];
}
