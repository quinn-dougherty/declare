{ inputs, ... }:

{
  imports = [ ./openssh.nix "${inputs.self}/secrets" ];
  services.hercules-ci-agents = {
    default.settings.staticSecretsDirectory = "/run/hercules-ci-agent-default-keys";
    casper.settings.staticSecretsDirectory = "/run/hercules-ci-agent-casper-keys";
  };
  networking.firewall.allowedTCPPorts = [ 443 ];
}
