{ agent, hercules-ci-agent, nixos-hardware }:

[
  (import ./system/configuration.nix { inherit agent hercules-ci-agent; })
  {
    _module.args.nixinate = {
      host = agent.ip;
      sshUser = "root"; # agent.username;
      buildOn = "local"; # valid args are "local" or "remote"
      substituteOnTarget =
        true; # if buildOn is "local" then it will substitute on the target, "-s"
      hermetic = true;
    };
  }
  # Touchpad wasn't working, so we tried commenting this out.
  # nixos-hardware.nixosModules.dell-latitude-3480 # This is actually a 3340, but why split hairs
]
