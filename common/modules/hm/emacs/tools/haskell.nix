{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    hlint
    stylish-haskell
    haskellPackages.cabal-fmt
    haskellPackages.lsp
  ];
}
