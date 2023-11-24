{ laptop, inputs }:
let
  modpath = ./../../modules;
  modpath-system = "${modpath}/system";
in
with inputs;
[
  ./system/configuration.nix
  "${modpath-system}/desktops/${laptop.desktop}"
  ./system/hardware-configuration.nix
  nixos-hardware.nixosModules.framework-13th-gen-intel
  secrix.nixosModules.default
  home-manager.nixosModules.home-manager
  ./users/homes.nix
  "${modpath-system}/manyterms.nix"
  "${modpath-system}/fonts.nix"
  "${modpath-system}/audio.nix"
  "${modpath-system}/bluetooth.nix"
  "${modpath-system}/crosscompilation.nix"
  "${modpath-system}/openssh.nix"
  "${modpath-system}/il8n.nix"
  inputs.battlenet.nixosModules.${laptop.system}.default
  { programs.battlenet.enable = true; gaming.opengl.intel = true; }
  # Testing/learning
  # "${modpath}/nextcloud"
  # "${modpath}/slurm.nix"
] ++ import "${modpath}/common.nix"
