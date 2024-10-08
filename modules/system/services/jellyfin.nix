{ machine, ... }:

{
  # networking.firewall.allowedTCPPorts = [ 8096 8920 ];
  services = {
    nginx = {
      # enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts."media.quinn-dougherty.com" = {
        addSSL = true;
        enableACME = true;
        locations."/".proxyPass = "http://127.0.0.1:8096";
      };
    };
    jellyfin = {
      enable = true;
      user = machine.username;
      openFirewall = true;
    };
    jellyseerr.enable = true;
  };
  security.acme = {
    acceptTerms = true;
    certs."media.quinn-dougherty.com".email = "quinnd@riseup.net";
  };
}
