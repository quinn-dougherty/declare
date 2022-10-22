# { config, lib, pkgs, ... }:
{ hercules-ci-agent }: {
  imports = [ hercules-ci-agent.nixosModules.agent-service ];
  services.hercules-ci-agent.enable = true;
  networking.firewall.allowedTCPPorts = [ 443 ];
}
