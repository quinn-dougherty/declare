{ pkgs, ... }:

let
  site = import ./soupault.nix { inherit pkgs; };
in
import ./nginx.nix { inherit site; }
