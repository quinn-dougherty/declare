{ nixpkgs, server, nixos-hardware, hercules-ci-agent }:
let modpath = ./../../modules;
in [
  (import ./system/configuration.nix { inherit server; })
  nixos-hardware.nixosModules.framework # 11th gen
  ./system/hardware-configuration.nix
  hercules-ci-agent.nixosModules.agent-service
  "${modpath}/cachix"
  "${modpath}/hercules.nix"
  # "${modpath}/nextcloud"
  (import "${modpath}/nix.nix" { inherit nixpkgs; })
  "${modpath}/audit.nix"
  "${modpath}/crosscompilation.nix"
  "${modpath}/observability.nix"
  "${modpath}/ivpn.nix"
  "${modpath}/devops.nix"
  # "${modpath}/slurm.nix"
  "${modpath}/utilities.nix"
  (import "${modpath}/jellyfin.nix" { inherit server; })
  "${modpath}/il8n.nix"
  "${modpath}/allowUnfree.nix"
  # Temp for jellyfin config
  "${modpath}/desktops/gnome"
]
