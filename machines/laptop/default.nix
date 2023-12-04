{ lib, laptop, inputs }:
let
  doom = import "${inputs.self}/modules/emacs" {
    inherit inputs;
    inherit (laptop) pkgs;
  };
in {
  inherit (laptop) system hostname drv-name-prefix;
  operatingsystem = lib.nixosSystem {
    system = laptop.system;
    specialArgs = {
      inherit inputs laptop doom;
      inherit (laptop) pkgs;
    };
    modules = import ./modules.nix { inherit inputs laptop; };
  };
  homeshell = with laptop;
    import "${inputs.self}/shells/developers/shell.nix" {
      inherit pkgs pkgs-stable drv-name-prefix;
    };
}
