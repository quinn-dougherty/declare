{ inputs, config, lib, pkgs, modulesPath, ... }:

let config = [ "${modulesPath}/virtualisation/digital-ocean-image.nix" ];
in (pkgs.nixos config).digitalOceanImage
