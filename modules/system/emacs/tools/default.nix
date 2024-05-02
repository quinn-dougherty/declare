{ inputs, pkgs, ... }:
let
  imports = f: import "${inputs.self}/modules/system/emacs/tools/${f}.nix" { inherit pkgs; };
in
[ pkgs.nixpkgs-fmt ]
++ builtins.concatLists (
  map imports [
    "haskell"
    "javascript"
    "python"
    "rust"
    "fonts"
    "markup"
    "ops"
    "c"
    "lean"
  ]
)
