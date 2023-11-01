{ laptop, nixos-hardware, home-manager, nix-doom-emacs, smos }:
let cmodpath = ./../../modules;
in [
  (import ./../system/configuration.nix { inherit laptop; })
  "${cmodpath}/desktops/${laptop.desktop}"
  ./../system/hardware-configuration.nix
  nixos-hardware.nixosModules.framework-13th-gen-intel
  home-manager.nixosModules.home-manager
  (import ./hm.nix { inherit laptop nix-doom-emacs smos; })
  "${cmodpath}/manyterms.nix"
  "${cmodpath}/fonts.nix"
  "${cmodpath}/audio.nix"
  "${cmodpath}/bluetooth.nix"
  "${cmodpath}/nix.nix"
  "${cmodpath}/cachix"
  "${cmodpath}/audit.nix"
  "${cmodpath}/observability.nix"
  "${cmodpath}/ivpn.nix"
  "${cmodpath}/crosscompilation.nix"
  "${cmodpath}/openssh.nix"
  "${cmodpath}/devops.nix"
  "${cmodpath}/il8n.nix"
  "${cmodpath}/utilities.nix"
]
