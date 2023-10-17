{ pkgs }:
# Integrated Graphics (tigerlake)
with pkgs; [
  mesa
  dxvk
  vkBasalt
  vulkan-tools
  vulkan-loader
  vulkan-extension-layer
  vulkan-headers
  vulkan-tools-lunarg
]
