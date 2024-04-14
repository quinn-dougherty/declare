let
  osFor = machine: {
    name = machine.hostname;
    value = machine.operatingsystem;
  };
  hmFor = machine: {
    name = "${machine.username}@${machine.hostname}";
    value = machine.homemanager;
  };
  packageFromX86 = machine: {
    name = machine.hostname;
    value = machine.operatingsystem.config.system.build.toplevel;
  };
  bootstrapPackageFromX86 = machine: {
    name = "${machine.hostname}-bootstrap";
    value = machine.bootstrap;
  };
  packageFromAarchDiskImg = machine: {
    name = "${machine.hostname}-disk-image";
    value = machine.operatingsystem.config.mobile.outputs.u-boot.disk-image;
  };
  packageFromAarchBootPartition = machine: {
    name = "${machine.hostname}-boot-partition";
    value = machine.operatingsystem.config.mobile.outputs.u-boot.boot-partition;
  };
  packageFromNonNixos = machine: {
    name = "${machine.drv-name-prefix}:homeconfig";
    value = machine.homemanager.activationPackage;
  };
  packagesFromAll = fromFn: machines: builtins.listToAttrs (map fromFn machines);
in
{
  osForAll = machines: builtins.listToAttrs (map osFor machines);
  hmForAll = machines: builtins.listToAttrs (map hmFor machines);
  packagesFromAllOs =
    {
      immobiles,
      mobiles,
      nonNixos,
    }:
    (packagesFromAll packageFromX86 immobiles)
    // (packagesFromAll bootstrapPackageFromX86 immobiles)
    // (packagesFromAll packageFromAarchDiskImg mobiles)
    // (packagesFromAll packageFromAarchBootPartition mobiles)
    // (packagesFromAll packageFromNonNixos nonNixos);
}
