{ pkgs }:
with pkgs; [
  lutris # Launcher
  bottles # Alt launcher
  gamemode # Cpu optimizations
  protonup-qt # Manage wine packages to finetune lutris (gui)
  protonup-ng # Manage wine packages (cli)
]
