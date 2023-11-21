{ config, lib, pkgs, ... }:

{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud27;
    configureRedis = true;
    hostName = "127.0.0.1";
    config = {
      adminuser = "qd-admin";
      adminpassFile = "${pkgs.writeText "adminpass" "test123"}";
    };
  };
}
