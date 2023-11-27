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
    virtualHosts."sync.quinn-dougherty.com" = {
      forceSSL = true;
      enableACME = true;
    };
  };
  security.acme = {
    acceptTerms = true;
    # Replace the email here!
    defaults.email = "quinnd@riseup.net";
  };

}
