{ framework, nixos-hardware, home-manager, nix-doom-emacs }:

[
  (import ./system/configuration.nix { inherit framework; })
  ./system/hardware-configuration.nix
  ./modules/x.nix
  nixos-hardware.nixosModules.framework
  home-manager.nixosModules.home-manager
  (import ./modules/hm.nix { inherit framework nix-doom-emacs; })
  ./../common/modules/audio.nix
  ./../common/modules/cachix
  ./../common/modules/dropbox.nix
  ./../common/modules/nix.nix
  ./../common/modules/audit.nix
]
