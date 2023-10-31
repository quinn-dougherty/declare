{ phone, home-manager, mobile-nixos }:

[
  (import ./../system/mobile.nix { inherit mobile-nixos; })
  (import ./../system/configuration.nix { inherit phone; })
  ./../system/hardware-configuration.nix
  home-manager.nixosModules.home-manager
  # (import ./phosh.nix { inherit pinephone; })
  ./plasma.nix
  ./qt.nix
  ./../../common/modules/manyterms.nix
  ./../../common/modules/openssh.nix
  ./../../common/modules/nix.nix
  ./../../common/modules/bluetooth.nix
  # ./../../common/modules/openssh.nix
  (import ./hm.nix { inherit phone; })
]
