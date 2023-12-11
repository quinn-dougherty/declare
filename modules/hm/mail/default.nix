{ doom, inputs, config, lib, pkgs, ... }:

{
  imports = [ ./accounts.nix ];
  services.mbsync = {
    enable = true;
    # frequency = "*:0/5";
    # configFile = ./mbsyncrc;
  };
  programs = {
    mu = {
      enable = true;
      package = pkgs.mu.override { emacs = doom; };
    };
    msmtp.enable = true;
    mbsync.enable = true;
  };
}
