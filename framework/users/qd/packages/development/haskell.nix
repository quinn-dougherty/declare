{ pkgs }:
with pkgs; [
  ## haskell
  stack
  cabal-install
  cabal2nix
  hlint
  stylish-haskell
  # stylish-cabal  # broken
  (agda.withPackages (ps: [ ps.standard-library ]))
]
