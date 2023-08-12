{ pkgs }:
with pkgs; [
  lutris # Launcher
  gamemode # Cpu optimizations
  protonup-qt # Manage wine packages to finetune lutris (gui)
  protonup-ng # Manage wine packages (cli)
  # Graphics
  mesa
  dxvk
  vkBasalt
  vulkan-tools
  vulkan-loader
  vulkan-extension-layer
  vulkan-headers
  vulkan-tools-lunarg
]
