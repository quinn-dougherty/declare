{ site, ... }:

{
  services.nginx = {
    enable = true;
    virtualHosts."quinn-dougherty.com" = {
      addSSL = true;
      enableACME = true;
      root = site;
    };
    security.acme = {
      acceptTerms = true;
      certs."quinn-dougherty.com".email = "quinnd@riseup.net";
    };
  };
}
