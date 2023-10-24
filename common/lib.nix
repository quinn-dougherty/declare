let
  osFor = machine: {
    name = machine.hostname;
    value = machine.operatingsystem;
  };
  hmFor = machine: {
    name = machine.hostname;
    value = machine.homemanager;
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
  packageFromOther = machine: {
    name = "${machine.drv-name-prefix}homeconfig";
    value = machine.homeconfig;
  };
  packagesFromAll = fromFn: machines:
    builtins.listToAttrs (map fromFn machines);
in {
  osForAll = machines: builtins.listToAttrs (map osFor machines);
  packagesFromAllOs = { immobiles, mobiles, others }:
    (packagesFromAll packageFromImmobile immobiles)
    // (packagesFromAll packageFromMobile mobiles)
    // (packagesFromAll packageFromOther others);
  hmForAll = machines: builtins.listToAttrs (map hmFor machines);
}
