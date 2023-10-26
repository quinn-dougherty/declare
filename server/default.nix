{ lib, server, nixos-hardware, hercules-ci-agent }:
let
  os = lib.nixosSystem {
    system = server.system;
    modules =
      import ./modules.nix { inherit server nixos-hardware hercules-ci-agent; };
  };
in
server // {
  operatingsystem = os;
  deploymenteffect-nixinate = { ref, nixination }:
    import ./effect/nixinate.nix { inherit ref server nixination; };
  deploymenteffect = { ref }:
    import ./effect {
      inherit ref server;
      server-os = os;
    };
}
