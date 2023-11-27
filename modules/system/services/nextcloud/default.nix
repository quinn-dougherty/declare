{ config, lib, pkgs, ... }:

{
  services = {
    nextcloud = {
      enable = true;
      package = pkgs.nextcloud27;
      hostName = "127.0.0.1";
      https = true;
      config = {
        # dbtype = "pgsql";
        adminuser = "qd-admin";
        adminpassFile = "${pkgs.writeText "adminpass" "test123"}";
      };
      configureRedis = true;
      # database.createLocally = true;
    };
    nginx.virtualHosts."sync.quinn-dougherty.com" =
      { # ${config.services.nextcloud.hostName} = {
        locations."/".proxyPass = "http://127.0.0.1:8080";
        forceSSL = true;
        enableACME = true;
      };
  };
  security.acme.certs."sync.quinn-dougherty.com".email = "quinnd@riseup.net";
  networking.firewall.allowedTCPPorts = [ 8080 80 ];
}
