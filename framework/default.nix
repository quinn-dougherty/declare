{ lib, framework, nixos-hardware, home-manager, sops-nix, nix-doom-emacs }:
framework // {
  operatingsystem = lib.nixosSystem {
    system = framework.system;
    modules = import ./modules {
      inherit framework nixos-hardware home-manager sops-nix nix-doom-emacs;
    };
  };
  homeshell = with framework;
    pkgs.mkShell {
      name = "${drv-name-prefix}:home-shell";
      buildInputs =
        import ./users/qd/packages/development { inherit pkgs pkgs-stable; };
    };
}
