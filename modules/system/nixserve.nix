{ config, lib, pkgs, ... }:
# https://nixos.wiki/wiki/Binary_Cache
{
  services = {
    nix-serve = {
      enable = true;
      secretKeyFile =
        "/run/nix-serve-keys/cache-priv-key.pem"; # just an example, not done yet, will be done with secrix
    };
    nginx = {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts = {
        # ... existing hosts config etc. ...
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
