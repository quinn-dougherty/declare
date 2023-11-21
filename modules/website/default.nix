{ inputs, pkgs, ... }:

let
  self = inputs.self;
  site = import ./soupault.nix { inherit pkgs self; };
in
import ./nginx.nix { inherit site; }
