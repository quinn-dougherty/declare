{ config, lib, pkgs, ... }:

{
  secrix.services.hercules-ci-agent.secrets = {
    "binary-caches.json" = {
      encrypted.file = ../common/secrets/binary-caches.json.age;
      # decrypted.user = "hercules-ci-agent";
      # decrypted.group = "hercules-ci-agent";
      decrypted.builder = ''
        mkdir -p /var/lib/hercules-ci-agent/secrets
        ln -s $inFile /var/lib/hercules-ci-agent/secrets/binary-caches.json
      '';
    };
    "secrets.json" = {
      encrypted.file = ../common/secrets/secrets.json.age;
      # decrypted.user = "hercules-ci-agent";
      # decrypted.group = "hercules-ci-agent";
      decrypted.builder = ''
        mkdir -p /var/lib/hercules-ci-agent/secrets
        ln -s $inFile /var/lib/hercules-ci-agent/secrets/secrets.json
      '';
    };
  };
  imports = [ ./openssh.nix ];
  services.hercules-ci-agent = {
    enable = true;
    settings.concurrentTasks = "auto";
  };
  networking.firewall.allowedTCPPorts = [ 443 ];
}
