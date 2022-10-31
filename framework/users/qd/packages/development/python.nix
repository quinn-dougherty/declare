{ pkgs }:
with pkgs; [
  (python-on-nix.python39Env {
    name = "qd@fw-home-python-development";
    projects = {
      "pytest" = "6.2.5";
      "nose" = "1.3.7";
      "flake8" = "3.9.2";
      "hypothesis" = "6.20.1";
    };
  }).dev
  # poetry  # update flake.lock pin job is failing
  mypy
  black
]
