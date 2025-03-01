{ pkgs, ... }:

with pkgs;
with nodePackages_latest;
[
  dune_3
  opam
]
