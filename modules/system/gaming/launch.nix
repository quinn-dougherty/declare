{ config, lib, pkgs, ... }:
with pkgs;
let
  wine-etc = [
    # wine # I think just for bootstrapping? lutris manages their own wines
    # wineWowPackages.stable
    lutris # Launcher
    # bottles # Alt launcher
    protonup-qt # Manage wine packages to finetune lutris (gui)
    protonup-ng # Manage wine packages (cli)
  ];
in
{
  environment.systemPackages = wine-etc; # builtins.concatLists [ [ runelite ] wine-etc ];
}
