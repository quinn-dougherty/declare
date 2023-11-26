{ config, lib, pkgs, ... }:

{
  imports = [
    ./haskell.nix
    ./javascript.nix
    ./python.nix
    ./rust.nix
    ./fonts.nix
    ./markup.nix
    ./ops.nix
  ];
  home.packages = with pkgs; [ nixpgks-fmt ];
}
