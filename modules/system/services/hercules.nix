{ inputs, ... }:

{
  imports = [ ./openssh.nix "${inputs.self}/secrets" ];
  services.hercules-ci-agents = {
    default.settings.staticSecretsDirectory = "/run/hci-default-keys";
    casper.settings.staticSecretsDirectory = "/run/hci-casper-keys";
  };
  networking.firewall.allowedTCPPorts = [ 443 ];
}
