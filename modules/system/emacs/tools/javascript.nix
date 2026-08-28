{ pkgs, ... }:

with pkgs;
[
  nodejs
  typescript
  # typescript-language-server # better for emacs to try to install itself
  prettier
  eslint
]
