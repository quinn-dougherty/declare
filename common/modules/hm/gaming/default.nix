{ config, lib, pkgs, ... }:
with pkgs;
let
  vulkan = [
    mesa
    dxvk
    vkBasalt
    vulkan-tools
    vulkan-loader
    vulkan-extension-layer
    vulkan-headers
    vulkan-tools-lunarg
  ];
in
{
  imports = [ ./light.nix ];
  home.packages = vulkan;
}
