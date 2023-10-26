{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # git  # In hm now
    # vim  # In hm now
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
