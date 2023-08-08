{ machines, agent-digitalocean-deploy, agent-latitude-deploy, outputs }:
let
  osFor = machine: {
    name = machine.hostname;
    value = machine.operatingsystem;
  };
  drvFrom = machine: {
    name = machine.hostname;
    value =
      outputs.nixosConfigurations.${machine.hostname}.config.system.build.toplevel;
  };
in {
  herc = import ./herc.nix {
    inherit outputs machines agent-digitalocean-deploy agent-latitude-deploy;
  };
  osForAll = machines: builtins.listToAttrs (map osFor machines);
  drvFromMobile = machineHostname:
    outputs.nixosConfigurations.${machineHostname}.config.mobile.u-boot.disk-image;
  drvFromAll = machines: builtins.listToAttrs (map drvFrom machines);
  lint = with machines; import ./lint.nix { inherit common; };
}
