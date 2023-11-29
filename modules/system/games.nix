{ inputs, config, lib, pkgs, ... }:

{
  imports = [ "${inputs.self}/secrets" ];
  environment.systemPackages = let
    factorio = pkgs.factorio.override {
      username = "quinnd";
      token = builtins.readFile
        config.secrix.system.secrets.factorio-token.decrypted.path;
    };
  in [ pkgs.runelite factorio ];
}
