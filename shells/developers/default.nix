{ pkgs, pkgs-stable }:

let
  lib = import ./../lib.nix { inherit pkgs pkgs-stable; };
in
with lib;
[
  {
    name = "rust";
    value = mkShell {
      name = "rust";
      nixpkgsSwitch = "unstable";
    };
  }
  {
    name = "js";
    value = mkShell {
      name = "js";
      nixpkgsSwitch = "unstable";
    };
  }
  {
    name = "coq";
    value = mkShell {
      name = "coq";
      nixpkgsSwitch = "unstable";
    };
  }
  {
    name = "python";
    value = mkShell {
      name = "python";
      nixpkgsSwitch = "unstable";
    };
  }
  # {
  #   name = "ocaml";
  #   value = mkShell {
  #     name = "ocaml";
  #     nixpkgsSwitch = "unstable";
  #   };
  # }
  {
    name = "haskell";
    value = mkShell {
      name = "haskell";
      nixpkgsSwitch = "unstable";
    };
  }
  # {
  #   name = "ruby";
  #   value = mkShell {
  #     name = "ruby";
  #     nixpkgsSwitch = "stable";
  #   };
  # }
]
