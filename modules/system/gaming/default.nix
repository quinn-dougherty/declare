{ pkgs, pkgs-stable, ... }:
with pkgs;
let
  vulkan = [
    jansson
    pkgs-stable.mesa
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
  imports = [ ./light.nix ./opengl32.nix ];
  environment.systemPackages = vulkan ++ intel;
}
