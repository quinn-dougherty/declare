{
  inputs,
  secrets,
  pkgs,
  ...
}:
# Battlenet is in flatpak now, these are lighter games.
{
  home.packages =
    let
    in
    # factorio = pkgs.factorio.override {
    #   username = "quinnd";
    #   token = "/var/lib/factorio/token";
    # };
    [
      pkgs.runelite
      pkgs.factorio
    ];
}
