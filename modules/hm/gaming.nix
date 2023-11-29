{ inputs, secrets, pkgs, ... }:
# Battlenet is in flatpak now, these are lighter games.
{
  home.packages = let
    factorio = pkgs.factorio.override {
      username = "quinnd";
      token = builtins.readFile secrets.factorio-token.decrypted.path;
    };
  in [ pkgs.runelite factorio ];
}
