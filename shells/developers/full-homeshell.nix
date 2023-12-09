{ pkgs, pkgs-stable, drv-name-prefix }:

pkgs.mkShell {
  name = "${drv-name-prefix}:home-shell";
  buildInputs = import ./programming { inherit pkgs pkgs-stable; };
}
