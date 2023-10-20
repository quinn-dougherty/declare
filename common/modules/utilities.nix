{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
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
    bitwarden
    bitwarden-cli
    bitwarden-menu
    pass
  ];
}
