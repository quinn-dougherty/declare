{ lib, laptop, nixos-hardware, home-manager, nix-doom-emacs, smos }:
laptop // {
  operatingsystem = lib.nixosSystem {
    system = laptop.system;
    # specialArgs = laptop;  # TODO: clean up all module declaration syntax with specialArgs
    modules = import ./modules {
      inherit laptop nixos-hardware home-manager nix-doom-emacs smos;
    };
  };
  homeshell = with laptop;
    pkgs.mkShell {
      name = "${drv-name-prefix}:home-shell";
      buildInputs =
        import ./users/qd/packages/development { inherit pkgs pkgs-stable; };
    };
}
