{ chat }:

[
  (import ./system/configuration.nix { inherit chat; })
  ./system/hardware-configuration.nix
  ./../modules/synapse.nix
  ./../modules/cachix
  ./../modules/digitalocean.nix
  ./../modules/audit.nix
  ./../modules/observability.nix
  ./../modules/utilities.nix
  ./../modules/allowUnfree.nix
]
