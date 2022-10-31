{ config, lib, pkgs, ... }:

{
  imports = [ ./openssh.nix ./default-packages.nix ];
  services.hercules-ci-agent = {
    enable = true;
    settings.concurrentTasks = "auto";
  };
  networking.firewall.allowedTCPPorts = [ 443 ];
}
