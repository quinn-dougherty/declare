{ config, lib, pkgs, ... }:

{
  hardware.opengl = {
    #  enable = false;
    #  extraPackages = with pkgs; [
    #    intel-media-driver
    #    intel-ocl
    #    intel-vaapi-driver
    #  ];
    driSupport32Bit = true; # helps with lutris?
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      vaapiIntel
    ];
  };
}
