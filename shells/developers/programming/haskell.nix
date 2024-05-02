{ pkgs }:
with pkgs;
[
  stack
  cabal-install
  cabal2nix
  ghc
  (agda.withPackages (ps: [ ps.standard-library ]))
]
