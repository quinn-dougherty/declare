{ pkgs }:
builtins.concatLists [
  [
    pkgs.runelite
  ]
  # (import ./blizzard.nix { inherit pkgs; })
]
