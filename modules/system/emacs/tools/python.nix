{ pkgs, ... }:

with pkgs;
# let pypkgs = ps: with ps; [ jedi-language-server ];
# in
[
  (python3.withPackages (
    ps: with ps; [
      numpy
      requests
      pyflakes
      isort
    ]
  ))
  openai
  black
  # poetry
  pyright
  rye
  uv
  conda
]
