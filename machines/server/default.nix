{ lib, inputs, server }:
let
  os = lib.nixosSystem {
    system = server.system;
    specialArgs = {
      inherit server inputs;
      inherit (server) pkgs;
    };
    modules = import ./modules.nix { inherit inputs; };
  };
in {
  inherit (server) system hostname;
  operatingsystem = os;
  deploymenteffect = { ref }:
    import ./effect {
      inherit ref server;
      server-os = os;
    };
}
