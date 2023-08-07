{ pkgs }:

with pkgs; [
  # useful CLI/admin tools to have during setup
  fatresize
  gptfdisk
  # networkmanager
  # sudo
  vim
  wget

  # it's good to have a variety of terminals (x11, Qt, GTK) to handle more failures
  xterm
  plasma5Packages.konsole
  gnome.gnome-terminal
]
