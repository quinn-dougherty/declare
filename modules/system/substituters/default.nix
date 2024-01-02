{ pkgs, lib, ... }:
with builtins; {
  nix.settings = fromJSON (readFile ./caches.json);
}
