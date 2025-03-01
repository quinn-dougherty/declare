{ pkgs, ... }:
{
  programs.nushell.enable = true;
  home.packages = with pkgs; [
    ripgrep
    curl
    age
    tmate
    bottom
    btop
    zip
    unzip
    cmake
    gnumake
    patchelf
    openssl
    tree
    diffsitter
    nix-tree
    wget
    jq
    pciutils
    ncdu
  ];
}
