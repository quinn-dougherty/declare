{ lib, inputs, server }:
let
  inherit (server) system;
  modules = import ./modules.nix { inherit inputs; };
  os = lib.nixosSystem {
    inherit system modules;
    specialArgs = {
      inherit server inputs;
      inherit (server) pkgs;
    };
  };
  bootstrap = inputs.nixos-generators.nixosGenerate {
    inherit system modules;
    specialArgs = {
      inherit server inputs;
      inherit (server) pkgs;
    };
    format = "iso";
  };
in {
  inherit (server) system hostname;
  inherit bootstrap;
  operatingsystem = os;
  deploymenteffect = { ref }:
    import ./effect {
      inherit ref server;
      server-os = os;
    };
}
