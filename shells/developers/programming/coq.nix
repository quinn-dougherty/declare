{ pkgs }:
with pkgs.coqPackages;
[
  coq
  coq-ext-lib
  # stdpp
  QuickChick
  ITree
  paco
  parsec
  simple-io
  mathcomp
  mathcomp-analysis
]
