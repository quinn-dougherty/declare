{ framework, nixos-hardware, home-manager, nix-doom-emacs }: {
  operatingsystem = framework.pkgs.lib.nixosSystem {
    system = framework.system;
    modules = import ./modules.nix {
      inherit framework nixos-hardware home-manager nix-doom-emacs;
    };
  };
  homeshell = with framework;
    pkgs.mkShell {
      name = "${drv-name-prefix}:home-shell";
      buildInputs =
        import ./users/qd/packages/development { inherit pkgs pkgs-stable; };
    };
}
