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
      lib = nixpkgs.lib;

      hostname = "fw";
      username = "qd";
      system = "x86_64-linux";
      config.allowUnfree = true;

      overlays = let
        factorioOverlay = final: prev: {
          factorio = prev.factorio.override {
            username = "quinnd";
            token = "\${FACTORIO_KEY}";
          };
        };
        pythonOnNixOverlay = final: prev: {
          python-on-nix = python-on-nix.lib.${system};
        };
      in [ factorioOverlay pythonOnNixOverlay ];
      pkgs = import nixpkgs { inherit system overlays config; };
      pkgs-stable = import nixpkgs-stable { inherit system overlays config; };
    in {
      nixosConfigurations.${hostname} = lib.nixosSystem {
        inherit system;
        modules = [
          ./system/configuration.nix
          nixos-hardware.nixosModules.framework
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              # useUserPackages = true;
              users.${username} = import ./users/qd/home.nix;
              # extraSpecialArgs.daedalus = daedalus;
            };
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
          ({
            home-manager.users.${username} = lib.mkMerge [
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

      devShells.${system}.default = pkgs.mkShell {
        name = "qd@fw-development-home";
        buildInputs =
          import ./users/qd/packages/development { inherit pkgs pkgs-stable; };
      };
    };
}
