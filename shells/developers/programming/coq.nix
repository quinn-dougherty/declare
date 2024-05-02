{ pkgs }:
with pkgs.coqPackages;
[
  coq
  coq-ext-lib
  stdpp
  # QuickChick # not in 8.18 yet
  # ITree # Not in 8.18 yet
  paco
  parsec
  simple-io
  mathcomp
  mathcomp-analysis
]
