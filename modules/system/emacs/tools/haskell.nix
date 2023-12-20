{ pkgs, ... }:

with pkgs; [
  hlint
  stylish-haskell
  haskellPackages.cabal-fmt
  haskellPackages.lsp
]
