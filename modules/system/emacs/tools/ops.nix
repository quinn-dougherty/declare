{ pkgs, ... }:

with pkgs; [
  cmake
  ix
  sqlite
  # mu
  mu.mu4e
  isync
]
