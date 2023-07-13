{ pkgs }:
with pkgs.coqPackages; [
  coq
  coq-ext-lib
  stdpp
  QuickChick
  ITree
  paco
  # parsec # deprecated apparently
  simple-io
  # VST # also not here anymore
  mathcomp
  mathcomp-analysis
]
