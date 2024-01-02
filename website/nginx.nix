{ site }:

{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
  };
  services.nginx = {
    enable = true;
    virtualHosts."quinn-dougherty.com" = {
      addSSL = true;
      enableACME = true;
      root = site;
    };
  };
  security.acme.certs."quinn-dougherty.com".email = "quinnd@riseup.net";
}
