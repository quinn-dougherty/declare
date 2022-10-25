{
  description = "quinnd's NixOS configurations";

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
    hercules-ci-agent = {
      url = "github:hercules-ci/hercules-ci-agent";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    hercules-ci-effects = {
      url = "github:hercules-ci/hercules-ci-effects";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    nixinate = {
      url = "github:matthewcroughan/nixinate";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    python-on-nix = {
      url = "github:on-nix/python";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # daedalus.url = github:input-output-hk/daedalus/chore/ddw-1083-flakes;
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixos-hardware, sops-nix
    , home-manager, nix-doom-emacs, hercules-ci-agent, hercules-ci-effects
    , nixinate, python-on-nix, ... }:
    let
      lib = nixpkgs.lib;
      machines = import ./common/machines.nix {
        inherit nixpkgs nixpkgs-stable python-on-nix hercules-ci-effects;
      };
    in with machines; rec {
      apps = nixinate.nixinate.${common.system} self;
      nixosConfigurations = {
        ${framework.hostname} = lib.nixosSystem {
          system = framework.system;
          modules = import ./framework/modules.nix {
            inherit framework nixos-hardware sops-nix home-manager
              nix-doom-emacs hercules-ci-agent;
          };
        };
        ${agent.hostname} = lib.nixosSystem {
          system = agent.system;
          modules = [
            (import ./agent/configuration.nix {
              inherit nixpkgs agent hercules-ci-agent;
            })
            {
              _module.args.nixinate = {
                host = "64.225.11.209";
                sshUser = "root";
                buildOn = "remote"; # valid args are "local" or "remote"
                substituteOnTarget =
                  true; # if buildOn is "local" then it will substitute on the target, "-s"
                # hermetic = false;
              };
            }
          ];
        };
      };

      devShells.${framework.system}.home-development = framework.pkgs.mkShell {
        name = "${framework.drv-name-prefix}:development-home";
        buildInputs = import ./framework/users/qd/packages/development {
          pkgs = framework.pkgs;
          pkgs-stable = framework.pkgs-stable;
        };
      };

      checks.${common.system}.lint =
        import ./common/lint.nix { inherit common; };

      herculesCI.onPush = {
        ${framework.hostname}.outputs = {
          development-home =
            self.devShells.${framework.system}.home-development;
          operating-system =
            self.nixosConfigurations.${framework.hostname}.config.system.build.toplevel;
        };
        ${agent.hostname}.outputs = {
          operating-system =
            self.nixosConfigurations.${agent.hostname}.config.system.build.toplevel;
          effects.deployment-effect = ref:
            import ./agent/effect.nix {
              inherit ref agent hercules-ci-agent;
              nixinateApps = self.apps.nixinate;
            };
        };
        dotfiles-lint.outputs = self.checks.${common.system}.lint;
      };
    };
}
