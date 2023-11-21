{ lib, laptop, inputs }:
{
  inherit (laptop) system hostname;
  operatingsystem = lib.nixosSystem {
    system = laptop.system;
    specialArgs = { inherit laptop inputs; }; # TODO: clean up all module declaration syntax with specialArgs
    modules = import ./modules.nix {
      inherit laptop inputs;
    };
  };
  homeshell = with laptop;
    import ./../../shells/developers/shell.nix {
      inherit pkgs pkgs-stable drv-name-prefix;
    };
}
