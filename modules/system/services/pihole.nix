{ config, lib, pkgs, ... }:

{
  # Pi-hole using NixOS modules
  services.pi-hole = {
    enable = true;

    # Use non-standard ports to avoid conflicts with existing services
    serverPort = 8080; # Web interface on port 8080 instead of 80
    ftlPort = 4443;    # Admin API on non-default port

    # DNS settings
    dns = {
      # Listen only on specific IP (your server's IP) and non-standard port
      # to avoid conflicts with existing DNS
      port = 5353;
      # You can choose upstream DNS providers
      upstreamServers = [
        "1.1.1.1"
        "1.0.0.1"
      ];
    };

    # Optional: set a password for the web interface
    webPassword = "your-secure-password";
  };

  # Open the required firewall ports
  networking.firewall.allowedTCPPorts = [ 8080 5353 4443 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];
}
