{ lib, inputs, server }:
let
  os = lib.nixosSystem {
    system = server.system;
    specialArgs = { inherit server inputs; };
    modules = import ./modules.nix {
      inherit server inputs;
    };
  };
in
server // {
  operatingsystem = os;
  deploymenteffect = { ref }:
    import ./effect {
      inherit ref server;
      server-os = os;
    };
}
