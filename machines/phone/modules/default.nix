{ lib, phone, inputs }:
with inputs; [
  ./../system/mobile.nix
  ./../system/configuration.nix
  ./../system/hardware-configuration.nix
  ./booter.nix
  secrix.nixosModules.default
  home-manager.nixosModules.home-manager
  ./plasma.nix
  # ./qt.nix
  "${inputs.self}/modules/system/manyterms.nix"
  ./hm.nix
]
