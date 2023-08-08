{ pkgs }:
with pkgs; [
  # useful CLI/admin tools to have during setup
  fatresize
  gptfdisk
  # networkmanager
  # sudo
  wget
  curl
]
