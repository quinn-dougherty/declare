{
  lib,
  inputs,
  server,
}:
let
  machine = server;
  inherit (server) system pkgs;
  modules = import ./modules.nix { inherit inputs; };
  specialArgs = {
    inherit machine inputs;
  };
  os = lib.nixosSystem { inherit system modules specialArgs; };
  bootstrap = inputs.nixos-generators.nixosGenerate {
    inherit system modules specialArgs;
    format = "iso";
  };
in
{
  inherit (server) system hostname;
  inherit bootstrap;
  operatingsystem = os;
  deploymenteffect =
    { ref }:
    import ./effect {
      inherit ref server;
      server-os = os;
    };
}
