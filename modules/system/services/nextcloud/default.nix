{ config, lib, pkgs, ... }:

{
  environment.etc."nextcloud-admin-pass".text = "test123";
  services = {
    nextcloud = {
      enable = true;
      package = pkgs.nextcloud27;
      hostName = "sync.quinn-dougherty.com";
      https = true;
      config = {
        # dbtype = "pgsql";
        adminuser = "qd-admin";
        adminpassFile = "/etc/nextcloud-admin-pass";
      };
      configureRedis = true;
      # database.createLocally = true;
    };
  };
  networking.firewall.allowedTCPPorts = [ 8080 80 8187 ];
}
