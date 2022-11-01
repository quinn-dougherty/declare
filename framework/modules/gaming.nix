{ config, lib, pkgs, ... }:
let factorio-token = config.age.secrets.factorio.file;
in {
  nixpkgs.overlays = [
    (final: prev: {
      factorio = prev.factorio.override {
        username = "quinnd";
        token = factorio-token;
      };
    })
  ];
  environment.systemPackages = with pkgs; [
    factorio
    lutris
    vulkan-tools
    vulkan-loader
    vulkan-extension-layer
    vulkan-headers
    # vulkan-tools-lunarg
    mesa
    vkBasalt
  ];
}
