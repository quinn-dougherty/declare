{ config, lib, pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  services.bluetooth.enable = true;
}
