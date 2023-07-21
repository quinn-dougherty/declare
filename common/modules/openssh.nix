{ config, lib, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings = {
      passwordAuthentication = false;
      kbdInteractiveAuthentication = false;
    };
  };
}
