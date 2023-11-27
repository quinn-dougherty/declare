{ config, lib, pkgs, ... }:

{
  services = {
    seafile = {
      enable = true;
      ccnetSettings = "http://sync.quinn-dougherty.com";
    };
    nginx.virtualHosts."sync.quinn-dougherty.com" = {
      addSSL = true;
      enableACME = true;
    };
  };
}
