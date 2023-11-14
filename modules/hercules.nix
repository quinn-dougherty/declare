{ config, lib, pkgs, ... }:

# let secrets = import ./secrets; in
{
  imports = [ ./openssh.nix ./secrets ];
  services.hercules-ci-agent = {
    enable = true;
    settings = {
      concurrentTasks = "auto";
      staticSecretsDirectory = "/run/hercules-ci-agent-keys"; # config.secrix.hercules-ci-agent.secrets;
    };
  };
  networking.firewall.allowedTCPPorts = [ 443 ];
}
