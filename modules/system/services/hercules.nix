{ inputs, ... }:

{
  imports = [ ./openssh.nix "${inputs.self}/secrets" ];
  services.hercules-ci-agents = {
    default = {
      # enable = true;
      settings = {
        concurrentTasks = "auto";
        staticSecretsDirectory = "/run/hercules-ci-agent-keys";
      };
    };
    casper = {
      # enable = true;
      settings = {
        concurrentTasks = "auto";
        staticSecretsDirectory = "/run/hercules-ci-agent-casper-keys";
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 443 ];
}
