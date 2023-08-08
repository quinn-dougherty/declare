{ pkgs }:
with pkgs; [
  stack
  cabal-install
  cabal2nix
  hlint
  stylish-haskell
  ghc
  # stylish-cabal  # broken
  (agda.withPackages (ps: [ ps.standard-library ]))
]
