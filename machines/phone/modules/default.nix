{ lib, phone, inputs }:
with inputs;
let modpath = ./../../../modules/system;
in [
  ./../system/mobile.nix
  ./../system/configuration.nix
  ./../system/hardware-configuration.nix
  ./booter.nix
  secrix.nixosModules.default
  home-manager.nixosModules.home-manager
  ./plasma.nix
  # ./qt.nix
  "${modpath}/manyterms.nix"
  "${modpath}/openssh.nix"
  "${modpath}/nix.nix"
  ./hm.nix
]
