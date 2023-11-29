{ inputs, pkgs, ... }:
let
  imports = f:
    import "${inputs.self}/modules/emacs/tools/${f}.nix" { inherit pkgs; };
in [ pkgs.nixpkgs-fmt ]
++ map imports [ "haskell" "javascript" "python" "rust" "fonts" "markup" "ops" ]
