{ nixpkgs, server, nixos-hardware, hercules-ci-agent, secrix }:
let modpath = ./../../modules/system;
in [
  (import ./system/configuration.nix { inherit server; })
  nixos-hardware.nixosModules.framework-11th-gen-intel
  ./system/hardware-configuration.nix
  hercules-ci-agent.nixosModules.agent-service
  secrix.nixosModules.default
  "${modpath}/wirelessregdom.nix"
  "${modpath}/cachix"
  "${modpath}/hercules.nix"
  (import "${modpath}/nix.nix" { inherit nixpkgs; })
  "${modpath}/audit.nix"
  "${modpath}/crosscompilation.nix"
  "${modpath}/observability.nix"
  "${modpath}/ivpn.nix"
  "${modpath}/devops.nix"
  # "${modpath}/slurm.nix"
  "${modpath}/utilities.nix"
  "${modpath}/il8n.nix"
  "${modpath}/allowUnfree.nix"
  (import "${modpath}/jellyfin.nix" { inherit server; })
  "${modpath}/nextcloud.nix"
  "${modpath}/website"
  # "${modpath}/desktops/gnome" # uncomment for a web browser jellyfin admin task
]
