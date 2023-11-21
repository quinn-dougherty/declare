{ laptop, ... }:
with laptop.pkgs;
let
  graphics = [
    jansson
    gamemode # Cpu optimizations
    laptop.pkgs-stable.mesa
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
  environment.systemPackages = graphics ++ intel;
}
