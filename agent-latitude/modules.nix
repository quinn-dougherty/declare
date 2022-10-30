{ agent, hercules-ci-agent, nixos-hardware }:

[
  (import ./system/configuration.nix { inherit agent hercules-ci-agent; })
  {
    _module.args.nixinate = {
      host = agent.ip;
      sshUser = agent.username;
      buildOn = "local"; # valid args are "local" or "remote"
      substituteOnTarget =
        true; # if buildOn is "local" then it will substitute on the target, "-s"
      hermetic = true;
    };
  }
  nixos-hardware.nixosModules.dell-latitude-3480
]
