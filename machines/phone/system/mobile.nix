{ inputs, ... }:
import "${inputs.mobile-nixos}/lib/configuration.nix" { device = "pine64-pinephone"; }
