{ agent, hercules-ci-agent }:

[
  (import ./configuration.nix { inherit agent hercules-ci-agent; })
  {
    _module.args.nixinate = {
      host = import ./host.nix;
      sshUser = "root"; # agent.username;
      buildOn = "local"; # valid args are "local" or "remote"
      substituteOnTarget =
        true; # if buildOn is "local" then it will substitute on the target, "-s"
      hermetic = true;
    };
  }
]
