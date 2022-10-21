{ hostname }: {
  hostName = hostname; # Define your hostname.
  wireless = {
    enable = true; # Enables wireless support via wpa_supplicant.
    userControlled.enable = true; # Enables wpa_supplicant gui
    allowAuxiliaryImperativeNetworks = true;
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  useDHCP = false;
  interfaces.wlp170s0.useDHCP = true;
  # interfaces.tailscale0.useDHCP = true;

  # Configure network proxy if necessary
  # proxy.default = "http://user:password@proxy:port/";
  # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # 17500 is for dropbox, 443 is for herc (I think)
  firewall.allowedTCPPorts = [ 17500 443 ];
  firewall.allowedUDPPorts = [ 17500 443 ];
  # Or disable the firewall altogether.
  # firewall.enable = false;
}
