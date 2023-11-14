{ nixpkgs, lib, server, nixos-hardware, hercules-ci-agent, web }:
let
  os = lib.nixosSystem {
    system = server.system;
    modules = import ./modules.nix {
      inherit nixpkgs server nixos-hardware hercules-ci-agent;
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
