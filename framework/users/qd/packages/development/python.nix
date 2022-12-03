{ pkgs }:
let
  python = pkgs.python310.buildEnv.override {
    extraLibs = with pkgs.python310Packages; [
      hypothesis
      flake8
      pytest
      mypy
      black
      nose
    ];
  };
in [ python pkgs.poetry ]
