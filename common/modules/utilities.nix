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
    unzip
    tree
    nix-tree
    _1password
    _1password-gui
    pass
  ];
}
