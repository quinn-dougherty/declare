{ config, lib, pkgs, ... }:

let
  intel = with pkgs; [ libdrm intel-media-driver intel-ocl intel-vaapi-driver ];
in
{
  environment.systemPackages = intel;
}
