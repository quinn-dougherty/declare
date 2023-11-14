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
      email = "quinnd@riseup.net";
    };
  };
}
