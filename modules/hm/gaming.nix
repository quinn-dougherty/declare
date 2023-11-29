{ laptop, inputs, secrets, ... }:
# Battlenet is in flatpak now, these are lighter games.
{
  home.packages = let
    factorio = laptop.pkgs.factorio.override {
      username = "quinnd";
      token = builtins.readFile secrets.factorio.decrypted.path;
    };
  in [ laptop.pkgs.runelite factorio ];
}
