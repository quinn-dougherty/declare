{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs.emacsPackages; [
    treemacs-all-the-icons
    all-the-icons-dired
    pkgs.emacs-all-the-icons-fonts
  ];
}
