{ lib, inputs, uptime }:
let
  os = lib.nixosSystem {
    system = uptime.system;
    specialArgs = { inherit uptime inputs; };
    modules = import ./modules.nix {
      inherit uptime inputs;
    };
  };
in
{
  inherit (inputs) system hostname;
  operatingsystem = os;
  deploymenteffect = { ref }:
    import ./effect {
      inherit ref uptime;
      server-os = os;
    };
}
