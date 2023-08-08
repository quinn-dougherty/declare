{ pkgs }:
with pkgs; [
  nodejs
  nodePackages.typescript
  yarn
  node2nix
  # haskellPackages.yarn2nix
  nodePackages.npm-check-updates
  nodePackages.prettier
  nodePackages.esy
]
