{ pkgs }:
with pkgs; [
  # nixops  # https://github.com/NixOS/nixops/issues/1521
  cachix
  # morph
  heroku
  hci
  # Secrets
  sops
  age
]
