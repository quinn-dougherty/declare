{ machines, agent, outputs }:
let
  osFor = { machine }: {
    ${machines.${machine.name}.hostname} = machine.operatingsystem;
  };
in {
  herc = import ./herc.nix { inherit machines agent outputs; };
  osForAll = operating-systems: builtins.map osFor operating-systems;
}
