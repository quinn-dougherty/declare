{ lib, phone, home-manager, mobile-nixos }:

[
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
  ./../../modules/manyterms.nix
  ./../../modules/openssh.nix
  ./../../modules/nix.nix
  ./../../modules/openssh.nix
  (import ./hm.nix { inherit phone; })
]
