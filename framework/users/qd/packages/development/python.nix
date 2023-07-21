{ pkgs }:
let
  python = pkgs.python311.buildEnv.override {
    extraLibs = with pkgs.python311Packages; [
      hypothesis
      flake8
      pytest
      mypy
      black
      nose
    ];
  };
in [ python pkgs.poetry ]
