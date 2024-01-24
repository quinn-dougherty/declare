{ inputs, ... }:

{
  imports = [ ./openssh.nix "${inputs.self}/secrets" ];
  services.hercules-ci-agents = {
    default = { enable = true; settings.staticSecretsDirectory = "/run/hci-default-keys"; };
    casper = { enable = true; settings.staticSecretsDirectory = "/run/hci-casper-keys"; };
  };
  networking.firewall.allowedTCPPorts = [ 443 ];
}
