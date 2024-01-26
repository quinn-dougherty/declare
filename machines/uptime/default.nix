{ lib, inputs, uptime }:
let
  system = uptime.system;
  modules = import ./modules.nix { inherit uptime inputs; };
  specialArgs = { inherit uptime inputs; };
  operatingsystem = lib.nixosSystem { inherit system modules specialArgs; };
  bootstrap = inputs.nixos-generators.nixosGenerate {
    inherit system modules specialArgs;
    inherit (uptime) pkgs;
    format = "do";
  };
in {
  inherit (uptime) system hostname;
  inherit bootstrap operatingsystem;
  deploymenteffect = { ref }:
    import ./effect {
      inherit ref uptime;
      uptime-os = operatingsystem;
    };
}
