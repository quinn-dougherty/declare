{ chat, secrix }:
let modpath = ./../../modules;
in [
  (import ./system/configuration.nix { inherit chat; })
  ./system/hardware-configuration.nix
  secrix.nixosModules.default
  "${modpath}/synapse.nix"
  "${modpath}/cachix"
  "${modpath}/digitalocean.nix"
  "${modpath}/audit.nix"
  "${modpath}/observability.nix"
  "${modpath}/utilities.nix"
  "${modpath}/allowUnfree.nix"
]
