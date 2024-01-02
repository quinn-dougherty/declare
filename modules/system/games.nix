{ inputs, config, lib, pkgs, ... }:

{
  imports = [ "${inputs.self}/secrets" ];
  config.allowUnfree = true;
  environment.systemPackages = let
    factorio = pkgs.factorio.override {
      username = "quinnd";
      token = builtins.readFile "/var/lib/factorio/token";
    };
  in [ pkgs.runelite factorio ];
}
