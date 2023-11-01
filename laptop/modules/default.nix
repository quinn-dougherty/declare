{ laptop, nixos-hardware, home-manager, nix-doom-emacs, smos }:
let modpath = ./../../modules;
in [
  (import ./../system/configuration.nix { inherit laptop; })
  "${modpath}/desktops/${laptop.desktop}"
  ./../system/hardware-configuration.nix
  nixos-hardware.nixosModules.framework-13th-gen-intel
  home-manager.nixosModules.home-manager
  (import ./hm.nix { inherit laptop nix-doom-emacs smos; })
  "${modpath}/manyterms.nix"
  "${modpath}/fonts.nix"
  "${modpath}/audio.nix"
  "${modpath}/bluetooth.nix"
  "${modpath}/nix.nix"
  "${modpath}/cachix"
  "${modpath}/audit.nix"
  "${modpath}/observability.nix"
  "${modpath}/ivpn.nix"
  "${modpath}/crosscompilation.nix"
  "${modpath}/openssh.nix"
  "${modpath}/devops.nix"
  "${modpath}/il8n.nix"
  "${modpath}/utilities.nix"

  # Testing/learning
  # "${modpath}/nextcloud"
]
