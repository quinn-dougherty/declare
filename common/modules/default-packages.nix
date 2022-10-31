{ config, lib, pkgs, ... }:

{
  environment.systemPackages = builtins.concatLists [
    (import ./../packages/utils.nix { inherit pkgs; })
    (import ./../packages/observability.nix { inherit pkgs; })
  ];
}
