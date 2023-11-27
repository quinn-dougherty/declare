{ inputs, server, config, lib, pkgs, ... }:

{
  services = {
    seafile = {
      enable = true;
      seafilePackage =
        inputs.nixpkgs-seafile.legacyPackages.${server.system}.seafile-server;
      adminEmail = "quinnd@riseup.net";
      initialAdminPassword = "test123";
      ccnetSettings = {
        General.SERVICE_URL = "http://sync.quinn-dougherty.com";
      };
    };
    nginx.virtualHosts."sync.quinn-dougherty.com" = {
      addSSL = true;
      enableACME = true;
    };
  };
  security.acme.certs."sync.quinn-dougherty.com".email = "quinnd@riseup.net";
}
