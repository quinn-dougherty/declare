{ pkgs, pkgs-stable }:

let
  nixpkgsSwitch = switch: if switch == "stable" then pkgs-stable else pkgs;
  mkShell = development:
    pkgs.mkShell {
      name = "${development.name}-developer";
      buildInputs = import ./programming/${development.name}.nix {
        pkgs = nixpkgsSwitch development.nixpkgsSwitch;
      };
    };
in
[
  {
    name = "rust";
    value = mkShell {
      name = "rust";
      nixpkgsSwitch = "stable";
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
  {
    name = "ocaml";
    value = mkShell {
      name = "ocaml";
      nixpkgsSwitch = "unstable";
    };
  }
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
