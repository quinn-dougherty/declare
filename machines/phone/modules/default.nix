{ lib, phone, home-manager, mobile-nixos }:

let modpath = ./../../../modules;
in [
  (import ./../system/mobile.nix { inherit mobile-nixos; })
  (import ./../system/configuration.nix { inherit phone; })
  ./../system/hardware-configuration.nix
  ./booter.nix
  home-manager.nixosModules.home-manager
  (import ./plasma.nix {
    inherit mobile-nixos lib;
    config = phone.config;
    pkgs = phone.pkgs;
  })
  # ./qt.nix
  "${modpath}/manyterms.nix"
  "${modpath}/openssh.nix"
  "${modpath}/nix.nix"
  "${modpath}/openssh.nix"
  (import ./hm.nix { inherit phone; })
]
