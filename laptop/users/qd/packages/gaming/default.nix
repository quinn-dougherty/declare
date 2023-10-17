{ pkgs }:
builtins.concatLists [
  [ pkgs.runelite ]
  (import ./wine.nix { inherit pkgs; })
  (import ./vulkan.nix { inherit pkgs; })
]
