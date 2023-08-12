{ pkgs }:
with pkgs; [
  stack
  cabal-install
  cabal2nix
  hlint
  stylish-haskell
  haskellPackages.cabal-fmt
  haskellPackages.lsp
  ghc
  (agda.withPackages (ps: [ ps.standard-library ]))
]
