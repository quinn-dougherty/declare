{ phone, home-manager, mobile-nixos }:

[
  (import ./../system/mobile.nix { inherit mobile-nixos; })
  (import ./../system/configuration.nix { inherit phone; })
  ./../system/hardware.nix
  home-manager.nixosModules.home-manager
  # (import ./phosh.nix { inherit pinephone; })
  ./plasma.nix
  ./qt.nix
  # ./../../common/modules/openssh.nix
  (import ./hm.nix { inherit phone; })
]
