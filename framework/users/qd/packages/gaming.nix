{ pkgs }:
with pkgs; [
  # Gaming
  # runescape
  runelite
  # factorio
  #  (wineWowPackages.full.override {
  #    wineRelease = "staging";
  #    mingwSupport = true;
  #  })
  #  winetricks
  protonup-qt
  lutris
  dxvk
  vulkan-tools
  vulkan-loader
  vulkan-extension-layer
  vulkan-headers
  vulkan-tools-lunarg
  mesa
  vkBasalt
]
