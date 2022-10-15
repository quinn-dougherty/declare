{ pkgs, python-on-nix }:
with pkgs; [
  (python-on-nix.lib.${pkgs.system}.python39Env {
    name = "qd@fw-home-python-development";
    projects = {
      "pytest" = "6.2.5";
      "nose" = "1.3.7";
      "flake8" = "3.9.2";
    };
  }).dev
  poetry
  mypy
  black
]
