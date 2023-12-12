{ inputs, laptop }:
let
  modpath = "${inputs.self}/modules";
  modpath-system = "${modpath}/system";
in with inputs;
[
  ./system/configuration.nix
  "${modpath-system}/desktops/${laptop.desktop}"
  ./system/hardware-configuration.nix
  nixos-hardware.nixosModules.framework-13th-gen-intel
  secrix.nixosModules.default
  home-manager.nixosModules.home-manager
  ./users/homes.nix
  "${modpath-system}/manyterms.nix"
  "${modpath-system}/desktops/fonts.nix"
  "${modpath-system}/desktops/audio.nix"
  "${modpath-system}/bluetooth.nix"
  "${modpath-system}/crosscompilation.nix"
  "${modpath-system}/desktops/il8n.nix"
  # "${modpath-system}/games.nix"
  # "${modpath-system}/services/flatpak.nix"
  inputs.nixos-generators.nixosModules.all-formats
] ++ import "${modpath}/common.nix"
