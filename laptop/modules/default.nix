{ laptop, nixos-hardware, home-manager, nix-doom-emacs, smos }:

[
  (import ./../system/configuration.nix { inherit laptop; })
  ./../system/hardware-configuration.nix
  ./x.nix
  nixos-hardware.nixosModules.framework-13th-gen-intel
  home-manager.nixosModules.home-manager
  (import ./hm.nix { inherit laptop nix-doom-emacs smos; })
  ./../../common/modules/fonts.nix
  ./../../common/modules/audio.nix
  ./../../common/modules/bluetooth.nix
  ./../../common/modules/nix.nix
  ./../../common/modules/cachix
  # ./../../common/modules/dropbox.nix
  # ./../../common/modules/dunst.nix # There's a hm take now
  ./../../common/modules/audit.nix
  ./../../common/modules/observability.nix
  ./../../common/modules/ivpn.nix
  ./../../common/modules/crosscompilation.nix
  ./../../common/modules/openssh.nix
  ./../../common/modules/devops.nix
  ./../../common/modules/il8n.nix
  ./../../common/modules/utilities.nix
]
