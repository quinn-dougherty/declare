{ server, inputs }:
let modpath = ./../../modules/system;
in with inputs; [
  ./system/configuration.nix
  nixos-hardware.nixosModules.framework-11th-gen-intel
  ./system/hardware-configuration.nix
  hercules-ci-agent.nixosModules.agent-service
  secrix.nixosModules.default
  "${modpath}/wirelessregdom.nix"
  "${modpath}/cachix"
  "${modpath}/hercules.nix"
  "${modpath}/nix.nix"
  "${modpath}/audit.nix"
  "${modpath}/crosscompilation.nix"
  "${modpath}/observability.nix"
  "${modpath}/ivpn.nix"
  "${modpath}/devops.nix"
  # "${modpath}/slurm.nix"
  "${modpath}/utilities.nix"
  "${modpath}/il8n.nix"
  "${modpath}/allowUnfree.nix"
  "${modpath}/nixserve.nix"
  "${modpath}/jellyfin.nix"
  "${modpath}/nextcloud.nix"
  "${modpath}/website"
  # "${modpath}/desktops/gnome" # uncomment for a web browser jellyfin admin task
]
