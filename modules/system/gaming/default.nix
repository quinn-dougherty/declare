{ laptop, config, lib, pkgs, ... }:
let graphics = import ./graphics.nix { inherit laptop; }; in
{
  imports = [ ./launch.nix graphics ./opengl32.nix ./steam.nix ];
}
