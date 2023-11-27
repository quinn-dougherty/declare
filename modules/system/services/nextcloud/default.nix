{ config, lib, pkgs, ... }:

{
  services = {
    nextcloud = {
      enable = true;
      package = pkgs.nextcloud27;
      hostName = "sync.quinn-dougherty.com";
      https = true;
      config = {
        adminuser = "qd-admin";
        adminpassFile = "${pkgs.writeText "adminpass" "test123"}";
      };
      configureRedis = true;
      database.createLocally = true;
    };
    nginx.virtualHosts.${config.services.nextcloud.hostName}.locations."/".proxyPass =
      "http://127.0.0.1:80";
  };
  networking.firewall.allowedTCPPorts = [ 8080 80 ];
}
