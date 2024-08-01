{ pkgs, ... }:

with pkgs;
# let pypkgs = ps: with ps; [ jedi-language-server ];
# in
[
  python3.withPackages
  (
    ps: with ps; [
      numpy
      requests
    ]
  )
  openai
  black
  # poetry
  pyright
  rye
  conda
]
