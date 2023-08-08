{ framework, nixos-hardware, home-manager, nix-doom-emacs }:

[
  (import ./../system/configuration.nix { inherit framework; })
  ./../system/hardware-configuration.nix
  ./x.nix
  nixos-hardware.nixosModules.framework
  home-manager.nixosModules.home-manager
  (import ./hm.nix { inherit framework nix-doom-emacs; })
  ./../../common/modules/audio.nix
  ./../../common/modules/bluetooth.nix
  ./../../common/modules/nix.nix
  ./../../common/modules/cachix
  ./../../common/modules/dropbox.nix
  ./../../common/modules/dunst.nix
  ./../../common/modules/audit.nix
  ./../../common/modules/observability.nix
  ./../../common/modules/crosscompilation.nix
  ./../../common/modules/openssh.nix
  ./../../common/modules/devops.nix
  ./../../common/modules/utilities.nix
]
