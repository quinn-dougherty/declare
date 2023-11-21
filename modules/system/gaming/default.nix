{ laptop, config, lib, pkgs, ... }:
let graphics = import ./graphics.nix { inherit laptop; }; in
{
  imports = [ ./misc.nix ./launch.nix graphics ./intel.nix ./opengl32.nix ./steam.nix ];
  # options.intel = lib.mkBoolOption false;
}
