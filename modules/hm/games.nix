{ inputs, secrets, pkgs, ... }:
# Battlenet is in flatpak now, these are lighter games.
{
  home.packages = let
    factorio = pkgs.factorio.override {
      username = "quinnd";
      token = "/var/lib/factorio/token";
    };
  in [ pkgs.runelite factorio ];
}
