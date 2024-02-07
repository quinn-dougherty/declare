{ pkgs, pkgs-stable }:
let
  coq-development = import ./coq.nix { inherit pkgs; };
  python-development = import ./python.nix { inherit pkgs; };
  rust-development = import ./rust.nix { pkgs = pkgs-stable; };
  javascript-development = import ./js.nix { inherit pkgs; };
  ocaml-development = import ./ocaml.nix { inherit pkgs; };
  haskell-development = import ./haskell.nix { inherit pkgs; };
  ruby-development = import ./ruby.nix { pkgs = pkgs-stable; };
in builtins.concatLists [
  coq-development
  python-development
  rust-development
  javascript-development
  # ocaml-development
  haskell-development
  ruby-development
  [ pkgs.nixfmt pkgs.nixpkgs-fmt ]
]
