{
  lib,
  laptop,
  inputs,
}:
let
  machine = laptop;
  inherit (laptop) system pkgs;
  specialArgs = {
    inherit inputs machine pkgs;
  };
  modules = import ./modules.nix { inherit inputs laptop; };
  bootstrap = inputs.nixos-generators.nixosGenerate {
    inherit system modules specialArgs;
    # inherit (laptop) pkgs;
    format = "iso";
  };
  operatingsystem = lib.nixosSystem { inherit system modules specialArgs; };
in
{
  inherit (laptop)
    system
    username
    hostname
    drv-name-prefix
    ;
  inherit bootstrap operatingsystem;
  homemanager = (import ./users/configurations.nix { inherit inputs laptop; }).${laptop.username};
  homeshell =
    with laptop;
    import "${inputs.self}/shells/developers/full-homeshell.nix" {
      inherit pkgs pkgs-stable drv-name-prefix;
    };
}
