{ machines, agent, outputs }:
let
  osFor = { machine }: {
    ${machines.${machine.name}.hostname} = {
      name = machine.name;
      value = machine.operatingsystem;
    };
  };
in {
  herc = import ./herc.nix { inherit machines agent outputs; };
  osForAll = operating-systems:
    builtins.listToAttrs (map osFor operating-systems);
  lint = with machines; import ../lint.nix { inherit common; };
}
