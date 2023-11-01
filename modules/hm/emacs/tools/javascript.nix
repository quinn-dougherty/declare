{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs;
    with nodePackages_latest; [
      typescript
      typescript-language-server
      prettier
      eslint
    ];
}
