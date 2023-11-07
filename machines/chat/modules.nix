{ chat }:
let modpath = ./../../modules;
in [
  (import ./system/configuration.nix { inherit chat; })
  ./system/hardware-configuration.nix
  "${modpath}/synapse.nix"
  "${modpath}/cachix"
  "${modpath}/digitalocean.nix"
  "${modpath}/audit.nix"
  "${modpath}/observability.nix"
  "${modpath}/utilities.nix"
  "${modpath}/allowUnfree.nix"
]
