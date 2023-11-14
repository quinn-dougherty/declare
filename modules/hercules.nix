{ config, lib, pkgs, ... }:

# let secrets = import ./secrets; in
{
  imports = [ ./openssh.nix ./secrets ];
  services.hercules-ci-agent = {
    enable = true;
    settings.concurrentTasks = "auto";
  };
  networking.firewall.allowedTCPPorts = [ 443 ];
}
