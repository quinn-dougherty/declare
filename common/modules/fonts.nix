{ config, lib, pkgs, ... }:

{
  fonts.packages = with pkgs; [ mononoki iosevka emacs-all-the-icons-fonts ];
}
