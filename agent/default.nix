{ lib, agent, hercules-ci-agent }:
agent // {
  # hostname = agent.hostname;
  operatingsystem = lib.nixosSystem {
    system = agent.system;
    modules = import ./modules.nix { inherit agent hercules-ci-agent; };
  };
  deploymenteffect = { ref, nixination }:
    import ./effect/nixinate.nix { inherit ref agent nixination; };
  deploymenteffect2 = { ref, agent-os }:
    import ./effect/run.nix { inherit ref agent-os; };
}
