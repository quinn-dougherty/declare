{ config, lib, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.mesa ];
  services.xserver = {
    # videoDrivers = [ "intel" "modesetting" ];
    deviceSection = ''
      Option "TearFree" "true"
    '';
  };
}
