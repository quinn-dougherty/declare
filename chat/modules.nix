{ chat }:

[
  (import ./system/configuration.nix { inherit chat; })
  ./../common/modules/synapse.nix
  ./../common/modules/cachix
  ./../common/modules/digitalocean.nix
]
