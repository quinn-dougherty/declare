{ config, lib, pkgs, ... }:

{
  imports = [ ./openssh.nix ];
  services.hercules-ci-agent = {
    enable = true;
    settings.concurrentTasks = "auto";
  };
  networking.firewall.allowedTCPPorts = [ 443 ];
}
