{ server, ... }:

{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 8096 8920 ];
  };
  services = {
    nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts."media.quinn-dougherty.com" = {
        addSSL = true;
        enableACME = true;
        locations."/".proxyPass = "http://localhost:8096";
      };
    };
    jellyfin = {
      enable = true;
      user = server.username;
    };
    jellyseerr.enable = true;
  };
  security.acme = {
    acceptTerms = true;
    certs."media.quinn-dougherty.com".email = "quinnd@riseup.net";
  };
}
