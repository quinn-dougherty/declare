# https://nixos.wiki/wiki/Binary_Cache
{ inputs, config, ... }:
{
  imports = [ "${inputs.self}/secrets" ];
  services = {
    nix-serve = {
      enable = true;
      secretKeyFile =
        "/run/nix-serve-keys/cache-qdpriv-key.pem";
    };
    nginx = {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts = {
        "bincache.quinn-dougherty.com" = {
          locations."/".proxyPass =
            "http://${config.services.nix-serve.bindAddress}:${
            toString config.services.nix-serve.port
          }";
        };
      };
    };
  };
}
