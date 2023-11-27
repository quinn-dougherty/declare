{ config, lib, pkgs, ... }: {
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud27;
    configureRedis = true;
    hostName = "sync.quinn-dougherty.com";
    config = {
      adminuser = "qd-admin";
      adminpassFile = "${pkgs.writeText "adminpass" "test123"}";
    };
  };
}
