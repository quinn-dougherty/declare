{ pkgs, pkgs-stable, ... }:

let
  lib = import ./lib.nix { inherit pkgs pkgs-stable; };
  developers = import ./developers { inherit pkgs pkgs-stable; };
in lib.developersWithPermutations developers
