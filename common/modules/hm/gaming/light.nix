{ config, lib, pkgs, ... }:
with pkgs;
let
  wine-etc = [
    wine # I think just for bootstrapping?
    lutris # Launcher
    # bottles # Alt launcher
    gamemode # Cpu optimizations
    protonup-qt # Manage wine packages to finetune lutris (gui)
    protonup-ng # Manage wine packages (cli)
  ];
in
{ home.packages = builtins.concatLists [ [ runelite ] wine-etc ]; }
