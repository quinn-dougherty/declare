let
  osFor = machine: {
    name = machine.hostname;
    value = machine.operatingsystem;
  };
  packageFromImmobile = machine: {
    name = machine.hostname;
    value = machine.operatingsystem.config.system.build.toplevel;
  };
  packageFromMobile = machine: {
    name = machine.hostname;
    value = machine.operatingsystem.config.mobile.outputs.u-boot.disk-image;
  };
  packagesFromAllImmobile = machines:
    builtins.listToAttrs (map packageFromImmobile machines);
  packagesFromAllMobile = machines:
    builtins.listToAttrs (map packageFromMobile machines);
in {
  osForAll = machines: builtins.listToAttrs (map osFor machines);
  packagesFromAllOs = { immobiles, mobiles }:
    (packagesFromAllImmobile immobiles) // (packagesFromAllMobile mobiles);
}
