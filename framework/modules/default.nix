{ framework, nixos-hardware, agenix, home-manager, nix-doom-emacs }:

[
  (import ./../system/configuration.nix { inherit framework; })
  ./../system/hardware-configuration.nix
  ./x.nix
  agenix.nixosModule
  nixos-hardware.nixosModules.framework
  home-manager.nixosModules.home-manager
  (import ./hm.nix { inherit framework nix-doom-emacs agenix; })
  ./../../common/modules/audio.nix
  ./../../common/modules/nix.nix
  ./../../common/modules/cachix
  ./../../common/modules/dropbox.nix
  ./../../common/modules/dunst.nix
  ./../../common/modules/audit.nix
  ./../../common/modules/observability.nix
  ./../../common/modules/utilities.nix
  ./../../common/modules/age-secrets.nix
]
