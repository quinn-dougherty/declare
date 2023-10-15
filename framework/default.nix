{ lib, framework, nixos-hardware, home-manager, nix-doom-emacs, smos }:
framework // {
  operatingsystem = lib.nixosSystem {
    system = framework.system;
    # specialArgs = framework;  # TODO: clean up all module declaration syntax with specialArgs
    modules = import ./modules {
      inherit framework nixos-hardware home-manager nix-doom-emacs smos;
    };
  };
  homeshell = with framework;
    pkgs.mkShell {
      name = "${drv-name-prefix}:home-shell";
      buildInputs =
        import ./users/qd/packages/development { inherit pkgs pkgs-stable; };
    };
}
