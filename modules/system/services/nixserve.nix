# https://nixos.wiki/wiki/Binary_Cache
{ inputs, config, ... }: {
  imports = [ "${inputs.self}/secrets" ];
  services = {
    nix-serve = {
      enable = true;
      secretKeyFile = "/run/nix-serve-keys/cache-qd-priv-key.pem";
    };
    nginx = {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts."bincache.quinn-dougherty.com" = {
        locations."/".proxyPass =
          "http://${config.services.nix-serve.bindAddress}:${
            toString config.services.nix-serve.port
          }";
        enableACME = true;
        addSSL = true;
      };
    };
  };
  security.acme = {
    acceptTerms = true;
    certs."bincache.quinn-dougherty.com".email = "quinnd@riseup.net";
  };
  users = {
    groups.nix-serve = { };
    users.nix-serve = {
      group = "nix-serve";
      isSystemUser = true;
    };
  };
}