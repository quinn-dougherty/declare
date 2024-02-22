{ pkgs, ... }: {
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
    nix-tree
    wget
    jq
    pciutils
    ncdu
  ];
}

