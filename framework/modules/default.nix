{ framework, nixos-hardware, home-manager, sops-nix, nix-doom-emacs }:

[
  (import ./../system/configuration.nix { inherit framework; })
  ./../system/hardware-configuration.nix
  ./x.nix
  nixos-hardware.nixosModules.framework
  sops-nix.nixosModules.sops
  home-manager.nixosModules.home-manager
  (import ./hm.nix { inherit framework nix-doom-emacs; })
  ./../../common/modules/audio.nix
  ./../../common/modules/nix.nix
  ./../../common/modules/cachix
  ./../../common/modules/dropbox.nix
  ./../../common/modules/dunst.nix
  ./../../common/modules/audit.nix
  ./../../common/modules/observability.nix
  ./../../common/modules/utilities.nix
]
