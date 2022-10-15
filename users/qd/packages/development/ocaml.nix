{ pkgs }:
with pkgs; [
  dune_3
  ocaml
  ocamlformat
  ocamlPackages.utop
  ocamlPackages.menhir
]
