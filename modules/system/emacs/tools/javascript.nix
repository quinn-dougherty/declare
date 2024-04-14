{ pkgs, ... }:

with pkgs;
with nodePackages_latest;
[
  nodejs
  typescript
  # typescript-language-server # better for emacs to try to install itself
  prettier
  eslint
]
