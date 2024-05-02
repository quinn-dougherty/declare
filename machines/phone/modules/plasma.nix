{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
import "${inputs.mobile-nixos}/examples/plasma-mobile/plasma-mobile.nix" {
  device = "pine64-pinephone";
  inherit config lib pkgs;
}
