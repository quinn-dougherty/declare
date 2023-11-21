{ server, inputs }:
let modpath = ./../../modules/system;
in with inputs; [
  ./system/configuration.nix
  # ./system/hardware-configuration.nix
  secrix.nixosModules.default
  # "${modpath}/allowUnfree.nix"
  # ./../../modules/website
] ++ import ./../../modules/common.nix
