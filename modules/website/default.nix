{ config, lib, pkgs, ... }:

let
  site = import ./soupault.nix { inherit pkgs; };
  nginx = import ./nginx {
    inherit site};
    in {
      imports= [ ./nginx.nix ];
    }
