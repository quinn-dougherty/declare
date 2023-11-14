{ server, ... }:

{
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
        locations."/" = { proxyPass = "http://localhost:8096"; };
      };
    };
    security.acme = {
      acceptTerms = true;
      certs."media.quinn-dougherty.com".email = "quinnd@riseup.net";
    };
    jellyfin = {
      enable = true;
      user = server.username;
    };
    jellyseerr.enable = true;
  };
}
