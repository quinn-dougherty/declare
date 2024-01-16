{ config, lib, pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ ];
  };
  environment.systemPackages = with pkgs; [ steam-run ];
}
