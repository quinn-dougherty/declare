{ machines, agent-digitalocean-deploy, outputs }:
let
  osFor = machine: {
    name = machine.hostname;
    value = machine.operatingsystem;
  };
in {
  herc =
    import ./herc.nix { inherit outputs machines agent-digitalocean-deploy; };
  osForAll = machines: builtins.listToAttrs (map osFor machines);
  lint = with machines; import ./lint.nix { inherit common; };
}
