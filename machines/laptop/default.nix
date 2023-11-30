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
    specialArgs = { inherit laptop inputs doom; };
    modules = import ./modules.nix { inherit laptop inputs; };
  };
  homeshell = with laptop;
    import "${inputs.self}/shells/developers/shell.nix" {
      inherit pkgs pkgs-stable drv-name-prefix;
    };
}
