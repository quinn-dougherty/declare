{ pkgs }:
with pkgs;
with nodePackages_latest;
[
  nodejs
  yarn
  node2nix
  # haskellPackages.yarn2nix
  npm-check-updates
  pnpm
  # turbo # broken rn
  bun
  stripe-cli
]
