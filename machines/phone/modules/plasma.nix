{ mobile-nixos, config, lib, pkgs }:
import "${mobile-nixos}/examples/plasma-mobile/plasma-mobile.nix" {
  device = "pine64-pinephone";
  inherit config lib pkgs;
}
