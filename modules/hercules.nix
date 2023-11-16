{ config, lib, pkgs, ... }:

{
  imports = [ ./openssh.nix ./secrets ];
  services.hercules-ci-agent = {
    enable = true;
    settings = {
      concurrentTasks = "auto";
      staticSecretsDirectory = "/run/hercules-ci-agent-keys";
    };
  };
  networking.firewall.allowedTCPPorts = [ 443 ];
}
