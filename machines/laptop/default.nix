{ lib, laptop, inputs }:
let
  # doom = import "${inputs.self}/packages/emacs" {
  #   inherit inputs;
  #   inherit (laptop) pkgs;
  # };
in {
  inherit (laptop) system username hostname drv-name-prefix;
  operatingsystem = lib.nixosSystem {
    system = laptop.system;
    specialArgs = {
      inherit inputs laptop;
      inherit (laptop) pkgs;
    };
    modules = import ./modules.nix { inherit inputs laptop; };
  };
  homemanager = (import ./users/configurations.nix {
    inherit inputs laptop;
  }).${laptop.username};
  homeshell = with laptop;
    import "${inputs.self}/shells/developers/full-homeshell.nix" {
      inherit pkgs pkgs-stable drv-name-prefix;
    };
}
