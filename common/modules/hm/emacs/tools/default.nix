{ config, lib, pkgs, ... }:

{
  imports = [ ./haskell.nix ./javascript.nix ./python.nix ./rust.nix ];
  home.packages = with pkgs; [ nixfmt ];
}
