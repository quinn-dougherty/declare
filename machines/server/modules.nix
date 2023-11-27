{ server, inputs }:
let
  modpath = "${inputs.self}/modules/system";
  servpath = "${modpath}/services";
in with inputs;
[
  ./system/configuration.nix
  nixos-hardware.nixosModules.framework-11th-gen-intel
  ./system/hardware-configuration.nix
  secrix.nixosModules.default
  hercules-ci-agent.nixosModules.agent-service
  "${servpath}/hercules.nix"
  "${modpath}/crosscompilation.nix"
  # "${modpath}/slurm.nix"
  "${modpath}/desktops/il8n.nix"
  "${modpath}/allowUnfree.nix"
  "${servpath}/nixserve.nix"
  "${servpath}/jellyfin.nix"
  "${servpath}/nextcloud"
  ./../../modules/website
  # "${modpath}/desktops/gnome" # uncomment to bootstrap webbrowser admin tasks.
] ++ import "${inputs.self}/modules/common.nix"
