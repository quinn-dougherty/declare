{ machines, agentdeploy, agentdeploy2, agent-os, outputs }:
let
  osFor = machine: {
    name = machine.hostname;
    value = machine.operatingsystem;
  };
in {
  herc = import ./herc.nix {
    inherit outputs machines agentdeploy agentdeploy2 agent-os;
  };
  osForAll = machines: builtins.listToAttrs (map osFor machines);
  lint = with machines; import ./lint.nix { inherit common; };
}
