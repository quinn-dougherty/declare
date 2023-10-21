# WARN: this file will get overwritten by $ cachix use <name>
{ pkgs, lib, ... }:
with builtins; {
  nix.settings = fromJSON (readFile ./caches.json);
}
