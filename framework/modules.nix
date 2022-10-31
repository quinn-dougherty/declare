{ framework, nixos-hardware, home-manager, nix-doom-emacs }:

[
  (import ./system/configuration.nix { inherit framework; })
  ./system/hardware-configuration.nix
  ./../common/modules/cachix
  nixos-hardware.nixosModules.framework
  home-manager.nixosModules.home-manager
  (import ./system/hm.nix { inherit framework nix-doom-emacs; })
  ./../common/modules/sound.nix
  ./../common/modules/dropbox.nix
  ./../common/modules/nix.nix
]
