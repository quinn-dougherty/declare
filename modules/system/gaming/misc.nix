{ config, lib, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.runelite ];
}
