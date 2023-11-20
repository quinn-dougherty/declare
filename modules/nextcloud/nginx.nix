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
    virtualHosts =
      let
        hostConfig = {
          forceSSL = true;
          enableACME = true;
        };
      in
      {
        "sync.quinn-dougherty.com" = hostConfig;
      };
  };
  security.acme = {
    acceptTerms = true;
    # Replace the email here!
    defaults.email = "quinnd@riseup.net";
  };

}
