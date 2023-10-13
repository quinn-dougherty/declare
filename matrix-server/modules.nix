{ chat }:

[
  (import ./system/configuration.nix { inherit chat; })
  ./system/hardware-configuration.nix
  ./../common/modules/synapse.nix
  ./../common/modules/cachix
  ./../common/modules/digitalocean.nix
  ./../common/modules/audit.nix
  ./../common/modules/observability.nix
  ./../common/modules/utilities.nix
  ./../common/modules/allowUnfree.nix
]
