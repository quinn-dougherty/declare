{ inputs, ... }:

{
  imports = [ ./openssh.nix "${inputs.self}/secrets" ];
  services.hercules-ci-agents = {
    default.settings.staticSecretsDirectory =
      "/run/hercules-ci-agent-default-keys";
    casper.settings = rec {
      staticSecretsDirectory = "/run/hercules-ci-agent-casper-keys";
      binaryCachesPath = "${staticSecretsDirectory}/binary-caches-casper.json";
      clusterJoinTokenPath =
        "${staticSecretsDirectory}/cluster-join-token-casper.key";
    };
  };
  networking.firewall.allowedTCPPorts = [ 443 ];
}
