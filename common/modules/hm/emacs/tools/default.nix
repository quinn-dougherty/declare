{ config, lib, pkgs, ... }:

{
  imports = [
    ./haskell.nix
    ./javascript.nix
    ./python.nix
    ./rust.nix
    ./fonts.nix
    ./latex.nix
  ];
  home.packages = with pkgs; [ nixpkgs-fmt sqlite ];
}
