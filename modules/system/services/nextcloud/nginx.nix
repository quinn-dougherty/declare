{ config, lib, pkgs, ... }:

{
  services.nginx = {

    # Use recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    # Only allow PFS-enabled ciphers with AES256
    sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";
    virtualHosts.${config.services.nextcloud.hostName} =
      { # "sync.quinn-dougherty.com" = {
        forceSSL = true;
        enableACME = true;
      };
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "quinnd@riseup.net";
  };
}
