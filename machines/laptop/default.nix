{ lib, laptop, inputs }: {
  inherit (laptop) system hostname drv-name-prefix;
  operatingsystem = lib.nixosSystem {
    system = laptop.system;
    specialArgs = { inherit laptop inputs; };
    modules = import ./modules.nix { inherit laptop inputs; };
  };
  homeshell = with laptop;
    import "${inputs.self}/shells/developers/shell.nix" {
      inherit pkgs pkgs-stable drv-name-prefix;
    };
}
