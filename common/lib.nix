let
  osFor = machine: {
    name = machine.hostname;
    value = machine.operatingsystem;
  };
  packageFromImmobile = machine: {
    name = machine.hostname;
    value = machine.operatingsystem.config.system.build.toplevel;
  };
  packageFromMobile = machine:
    let mobile-uboot = machine.operatingsystem.config.mobile.outputs.u-boot;
    in {
      name = machine.hostname;
      value = {
        disk-image = mobile-uboot.disk-image;
        boot-partition = mobile-uboot.boot-partition;
      };
    };
  packagesFromAll = fromFn: machines:
    builtins.listToAttrs (map fromFn machines);
in {
  osForAll = machines: builtins.listToAttrs (map osFor machines);
  packagesFromAllOs = { immobiles, mobiles }:
    (packagesFromAll packageFromImmobile immobiles)
    // (packagesFromAll packageFromMobile mobiles);
}
