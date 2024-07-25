{ pkgs, ... }:
{
  services.syncthing.enable = true;
  environment.systemPackages = [ pkgs.syncthing pkgs.syncthingtray ];
}
