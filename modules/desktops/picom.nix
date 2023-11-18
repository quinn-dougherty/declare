{ config, lib, pkgs, ... }:

{
  services.picom = {
    enable = true;
    vSync = true;
    # inactiveOpacity = 0.73;
  };
}
