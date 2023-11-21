{ laptop, inputs }:
let modpath = ./../../modules/system;
in with inputs; [
  ./system/configuration.nix
  "${modpath}/desktops/${laptop.desktop}"
  ./system/hardware-configuration.nix
  nixos-hardware.nixosModules.framework-13th-gen-intel
  secrix.nixosModules.default
  home-manager.nixosModules.home-manager
  (import ./users/homes.nix { inherit laptop nix-doom-emacs smos; })
  "${modpath}/gaming"
  "${modpath}/manyterms.nix"
  "${modpath}/fonts.nix"
  "${modpath}/audio.nix"
  "${modpath}/bluetooth.nix"
  "${modpath}/nix.nix"
  "${modpath}/cachix"
  "${modpath}/audit.nix"
  "${modpath}/observability.nix"
  "${modpath}/wirelessregdom.nix" # update if travel outside of US
  "${modpath}/ivpn.nix"
  "${modpath}/crosscompilation.nix"
  "${modpath}/openssh.nix"
  "${modpath}/devops.nix"
  "${modpath}/il8n.nix"
  "${modpath}/utilities.nix"

  # Testing/learning
  # "${modpath}/nextcloud"
  # "${modpath}/slurm.nix"
]
