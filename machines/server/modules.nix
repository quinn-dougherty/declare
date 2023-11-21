{ server, inputs }:
let modpath = ./../../modules/system;
in with inputs; [
  ./system/configuration.nix
  nixos-hardware.nixosModules.framework-11th-gen-intel
  ./system/hardware-configuration.nix
  secrix.nixosModules.default
  hercules-ci-agent.nixosModules.agent-service
  "${modpath}/hercules.nix"
  "${modpath}/crosscompilation.nix"
  # "${modpath}/slurm.nix"
  "${modpath}/il8n.nix"
  "${modpath}/allowUnfree.nix"
  "${modpath}/nixserve.nix"
  "${modpath}/jellyfin.nix"
  "${modpath}/nextcloud.nix"
  ./../../modules/website
  # "${modpath}/desktops/gnome" # uncomment to bootstrap webbrowser admin tasks.
] ++ import ./../../modules/common.nix
