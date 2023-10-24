{ pkgs }:
with pkgs;
with nodePackages_latest; [
  nodejs
  typescript
  typescript-language-server
  yarn
  node2nix
  # haskellPackages.yarn2nix
  npm-check-updates
  prettier
]
