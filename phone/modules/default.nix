{ pinephone, home-manager, mobile-nixos }:

[
  (import ./../system/configuration.nix { inherit pinephone mobile-nixos; })
  ./../system/hardware-configuration.nix
  home-manager.nixosModules.home-manager
  (import ./phosh.nix { inherit pinephone; })
  ./../../common/modules/openssh.nix
  ./hm.nix
]
