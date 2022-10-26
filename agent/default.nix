{ agent, hercules-ci-agent }: {
  operatingsystem = agent.pkgs.lib.nixosSystem {
    system = agent.system;
    modules = import ./modules.nix { inherit agent hercules-ci-agent; };
  };
  deployeffect = { ref, nixination }:
    import ./effect { inherit ref agent nixination; };
}
