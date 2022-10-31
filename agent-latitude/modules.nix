{ agent, nixos-hardware, hercules-ci-agent }:

[
  (import ./system/configuration.nix { inherit agent; })
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
  # The `nixos-hardware` module breaks the touchpad
  # https://github.com/NixOS/nixos-hardware/blob/419dcc0ec767803182ed01a326f134230578bf60/dell/latitude/3480/default.nix#L11
  nixos-hardware.nixosModules.dell-latitude-3340
  ./system/hardware-configuration.nix
  hercules-ci-agent.nixosModules.agent-service
  ./../common/cachix.nix
]
