{ pkgs }:
with pkgs; [
  # it's good to have a variety of terminals (x11, Qt, GTK) to handle more failures
  xterm
  plasma5Packages.konsole
  gnome.gnome-terminal
]
