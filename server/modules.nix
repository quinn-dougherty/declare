{ server, nixos-hardware, hercules-ci-agent }:

[
  (import ./system/configuration.nix { inherit server; })
  {
    _module.args.nixinate = {
      host = server.ip;
      sshUser = "root"; # server.username;
      buildOn = "local"; # valid args are "local" or "remote"
      substituteOnTarget =
        true; # if buildOn is "local" then it will substitute on the target, "-s"
      hermetic = true;
    };
  }
  nixos-hardware.nixosModules.framework # 11th gen
  ./system/hardware-configuration.nix
  hercules-ci-agent.nixosModules.agent-service
  ./../common/modules/cachix
  ./../common/modules/hercules.nix
  # ./../common/modules/nextcloud.nix
  ./../common/modules/nix.nix
  ./../common/modules/audit.nix
  ./../common/modules/crosscompilation.nix
  ./../common/modules/observability.nix
  ./../common/modules/ivpn.nix
  ./../common/modules/devops.nix
  ./../common/modules/utilities.nix
  ./../common/modules/il8n.nix
  ./../common/modules/allowUnfree.nix
]
