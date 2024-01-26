{ uptime, inputs }:
let modpath = "${inputs.self}/modules/system";
in with inputs;
[
  ./system/digital-ocean.nix
  ./system/configuration.nix
  secrix.nixosModules.default
  # "${modpath}/allowUnfree.nix"
] ++ import "${modpath}/common"
