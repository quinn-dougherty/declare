{ lib, nixpkgs, laptop, nixos-hardware, secrix, home-manager, nix-doom-emacs, smos }:
laptop // {
  operatingsystem = lib.nixosSystem {
    system = laptop.system;
    # specialArgs = laptop;  # TODO: clean up all module declaration syntax with specialArgs
    modules = import ./modules.nix {
      inherit nixpkgs laptop nixos-hardware secrix home-manager nix-doom-emacs smos;
    };
  };
  homeshell = with laptop;
    import ./../../shells/developers/shell.nix {
      inherit pkgs pkgs-stable drv-name-prefix;
    };
}
