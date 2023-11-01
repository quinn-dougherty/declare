{ server, nixos-hardware, hercules-ci-agent }:

[
  (import ./system/configuration.nix { inherit server; })
  nixos-hardware.nixosModules.framework # 11th gen
  ./system/hardware-configuration.nix
  hercules-ci-agent.nixosModules.agent-service
  ./../modules/cachix
  ./../modules/hercules.nix
  # ./../modules/nextcloud
  ./../modules/nix.nix
  ./../modules/audit.nix
  ./../modules/crosscompilation.nix
  ./../modules/observability.nix
  ./../modules/ivpn.nix
  ./../modules/devops.nix
  ./../modules/utilities.nix
  ./../modules/il8n.nix
  ./../modules/allowUnfree.nix
]
