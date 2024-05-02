{ pkgs, ... }:

with pkgs;
# let pypkgs = ps: with ps; [ jedi-language-server ];
# in
[
  openai
  black
  # poetry
  nodePackages.pyright
  rye
]
