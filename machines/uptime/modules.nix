{ uptime, inputs }:
let
  modpath = "${inputs.self}/modules/system";
in
with inputs;
[
  ./system/configuration.nix
  secrix.nixosModules.default
  # "${modpath}/allowUnfree.nix"
]
++ import "${modpath}/common"
