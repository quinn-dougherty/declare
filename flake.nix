{
  description = "qd@fw";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-22.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hercules-ci-agent.url = "github:hercules-ci/hercules-ci-agent";
    python-on-nix = {
      url = "github:on-nix/python";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # daedalus.url = github:input-output-hk/daedalus/chore/ddw-1083-flakes;
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixos-hardware, sops-nix
    , home-manager, nix-doom-emacs, hercules-ci-agent, python-on-nix, ... }:
    let
      system = "x86_64-linux";
      commonConfig = {
        allowUnfree = true;
        overlays = final: prev: {
          factorio = prev.factorio.override {
            username = "quinnd";
            token = "\${FACTORIO_KEY}";
          };
        };
      };
      pkgs = import nixpkgs {
        inherit system;
        config = commonConfig;
      };
      lib = nixpkgs.lib;
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config = commonConfig;
      };
    in {
      nixosConfigurations = {
        fw = lib.nixosSystem {
          inherit system;
          modules = [
            ./system/configuration.nix
            nixos-hardware.nixosModules.framework
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.qd = import ./users/qd/home.nix;
                # extraSpecialArgs.daedalus = daedalus;
              };
              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
            ({
              home-manager.users.qd = lib.mkMerge [
                nix-doom-emacs.hmModule
                {
                  programs.doom-emacs = {
                    enable = true;
                    doomPrivateDir = ./users/qd/doom.d;
                  };
                }
              ];
            })
            ({ config, lib, pkgs, ... }: {
              imports = [ hercules-ci-agent.nixosModules.agent-service ];
              services.hercules-ci-agent.enable = true;
              networking.firewall.allowedTCPPorts = [ 443 ];
            })
          ];
        };
      };
      devShells.${system}.default = let
        coq-development = import ./users/qd/packages/development/coq.nix {
          pkgs = pkgs-stable;
        };
        python-development = import ./users/qd/packages/development/python.nix {
          inherit pkgs python-on-nix;
        };
        rust-development = import ./users/qd/packages/development/rust.nix {
          pkgs = pkgs-stable;
        };
        javascript-development =
          import ./users/qd/packages/development/javascript.nix {
            inherit pkgs;
          };
        ocaml-development =
          import ./users/qd/packages/development/ocaml.nix { inherit pkgs; };
        haskell-development =
          import ./users/qd/packages/development/haskell.nix { inherit pkgs; };
        ruby-development = import ./users/qd/packages/development/ruby.nix {
          pkgs = pkgs-stable;
        };
      in pkgs.mkShell {
        name = "qd@fw-development-home";
        buildInputs = builtins.concatLists [
          coq-development
          python-development
          rust-development
          javascript-development
          ocaml-development
          ruby-development
          [ pkgs.nixfmt ]
        ];
      };
    };
}
