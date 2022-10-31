{ lib, agent, nixos-hardware-3340, hercules-ci-agent }:
let
  os = lib.nixosSystem {
    system = agent.system;
    modules = import ./modules.nix {
      inherit agent nixos-hardware-3340 hercules-ci-agent;
    };
  };
in agent // {
  operatingsystem = os;
  deploymenteffect-nixinate = { ref, nixination }:
    import ./effect/nixinate.nix { inherit ref agent nixination; };
  deploymenteffect = { ref }:
    import ./effect {
      inherit ref agent;
      agent-os = os;
    };
}
