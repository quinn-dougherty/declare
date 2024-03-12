{ config, lib, pkgs, ... }:

{
  imports = [ ./../xwayland.nix ];
  services.xserver = {
    enable = true;
    desktopManager.plasma6.enable = true;
    displayManager = {
      sddm.enable = true;
      defaultSession = "plasma";
    };
  };
  programs = {
    dconf.enable = true;
    kdeconnect.enable = true;
  };
  qt.platformTheme = "kde";
  environment = {
    systemPackages = with pkgs.libsForQt5; [ qtgraphicaleffects kio kio-admin ];
    sessionVariables.SSH_ASKPASS_REQUIRE = "prefer";
  };
}
