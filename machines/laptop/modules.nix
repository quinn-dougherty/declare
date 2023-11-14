{ nixpkgs, laptop, nixos-hardware, secrix, home-manager, nix-doom-emacs, smos }:
let modpath = ./../../modules;
in [
  (import ./system/configuration.nix { inherit laptop; })
  "${modpath}/desktops/${laptop.desktop}"
  ./system/hardware-configuration.nix
  nixos-hardware.nixosModules.framework-13th-gen-intel
  home-manager.nixosModules.home-manager
  (import ./users/homes.nix { inherit laptop nix-doom-emacs smos; })
  "${modpath}/manyterms.nix"
  secrix.nixosModules.default
  "${modpath}/fonts.nix"
  "${modpath}/audio.nix"
  "${modpath}/bluetooth.nix"
  (import "${modpath}/nix.nix" { inherit nixpkgs; })
  "${modpath}/cachix"
  "${modpath}/audit.nix"
  "${modpath}/observability.nix"
  "${modpath}/ivpn.nix"
  "${modpath}/crosscompilation.nix"
  "${modpath}/openssh.nix"
  # "${modpath}/slurm.nix"
  "${modpath}/devops.nix"
  "${modpath}/il8n.nix"
  "${modpath}/utilities.nix"

  # Testing/learning
  # "${modpath}/nextcloud"
]
