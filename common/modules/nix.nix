{ config, lib, pkgs, ... }:

{
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
      min-free = ${toString (2048 * 1024 * 1024)}
      max-free = ${toString (16 * 1024 * 1024 * 1024)}
    '';
    settings.auto-optimise-store = true;
  };
}
