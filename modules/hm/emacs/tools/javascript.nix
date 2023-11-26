{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs;
    with nodePackages_latest; [
      typescript
      # typescript-language-server # better for emacs to try to install itself
      prettier
      eslint
    ];
}
