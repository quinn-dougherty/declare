{ pkgs }:
with pkgs; [
  wpa_supplicant_gui
  git
  vim
  wget
  curl
  # Utils
  gnumake
  patchelf
  unzip
  tree
  ## docker
  docker-compose
]
