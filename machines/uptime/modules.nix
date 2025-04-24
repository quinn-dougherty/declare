{ uptime, inputs }:
let
  modpath = "${inputs.self}/modules/system";
in
with inputs;
[
  ./system/configuration.nix
  "${modpath}/amazon.nix"
  secrix.nixosModules.default
]
++ import "${modpath}/common"
