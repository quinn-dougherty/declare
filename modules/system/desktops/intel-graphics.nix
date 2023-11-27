{ config, lib, pkgs, ... }:

{
  services.xserver = {
    videoDrivers = [ "intel" "modesetting" ];
    deviceSection = ''
      Option "TearFree" "true"
    '';
  };
}
