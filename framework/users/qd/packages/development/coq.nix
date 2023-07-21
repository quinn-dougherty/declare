{ pkgs }:
with pkgs.coqPackages; [
  coq
  coq-ext-lib
  stdpp
  QuickChick
  ITree
  paco
  # parsec # not for latest coq version
  simple-io
  # VST # not for latest coq version
  mathcomp
  mathcomp-analysis
]
