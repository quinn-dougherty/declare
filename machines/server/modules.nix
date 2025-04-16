{ inputs }:
let
  website = "${inputs.self}/website";
  modpath = "${inputs.self}/modules/system";
  servpath = "${modpath}/services";
in
with inputs;
[
  ./system/configuration.nix
  nixos-hardware.nixosModules.framework-11th-gen-intel
  ./system/hardware-configuration.nix
  secrix.nixosModules.default
  hercules-ci-agent.nixosModules.multi-agent-service
  "${servpath}/hercules.nix"
  "${modpath}/crosscompilation.nix"
  # "${modpath}/slurm.nix"
  "${modpath}/desktops/il8n.nix"
  "${modpath}/allowUnfree.nix"
  {
    services.nginx.enable = true;
    networking.firewall.enable = true;
    security.acme.acceptTerms = true;
  }
  "${servpath}/nixserve.nix"
  "${servpath}/jellyfin.nix"
  {
    networking.firewall = {
      allowedTCPPorts = [
        5354
        8080
      ];
      allowedUDPPorts = [ 5354 ];
    }; # docker/pihole
  }
  "${servpath}/technitium.nix"
  "${servpath}/vault.nix"
  # "${servpath}/nextcloud"
  # "${servpath}/seafile"
  # "${servpath}/webdav.nix"
  website
  # "${modpath}/desktops/gnome" # uncomment to bootstrap webbrowser admin tasks. Remember that networkmanager is activated by gnome, so check `wireless.enable` when you switch
]
++ import "${inputs.self}/modules/system/common"
