{ config, lib, pkgs, ... }:
with pkgs;
let
  wine-etc = [
    wine # I think just for bootstrapping?
    # wineWowPackages.stable
    lutris # Launcher
    # bottles # Alt launcher
    gamemode # Cpu optimizations
    protonup-qt # Manage wine packages to finetune lutris (gui)
    protonup-ng # Manage wine packages (cli)
  ];
in
{
  environment.systemPackages = builtins.concatLists [ [ runelite ] wine-etc ];
}
