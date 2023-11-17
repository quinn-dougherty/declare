{ pkgs, ... }:
with pkgs;
let
  vulkan = [
    jansson
    mesa
    dxvk
    vkdt
    vkd3d-proton
    vkBasalt
    vulkan-tools
    vulkan-loader
    vulkan-extension-layer
    vulkan-headers
    vulkan-tools-lunarg
  ];
  intel = [ libdrm intel-media-driver intel-ocl intel-vaapi-driver ];
in
{
  imports = [ ./light.nix ];
  home.packages = vulkan ++ intel;
}
