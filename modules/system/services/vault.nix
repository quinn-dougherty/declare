{
  config,
  lib,
  pkgs,
  ...
}:

{
  services = {
    vaultwarden = {
      enable = true;
      config = {
        ROCKET_ADDRESS = "::1";
        ROCKET_PORT = 8222;
        DOMAIN = "https://vault.quinn-dougherty.com";
      };
    };
    nginx.virtualHosts."vault.quinn-dougherty.com" = {
      enableACME = true;
      forceSSL = true;
      locations."/".proxyPass =
        "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
    };
  };
}
