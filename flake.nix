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
              inherit agent hercules-ci-agent;
            })
            {
              _module.args.nixinate = {
                host = "64.225.11.209";
                sshUser = "root"; # agent.username;
                buildOn = "local"; # valid args are "local" or "remote"
                substituteOnTarget =
                  true; # if buildOn is "local" then it will substitute on the target, "-s"
                hermetic = true;
              };
            }
          ];
        };
      };

      devShells.${framework.system}.home-development = with framework;
        pkgs.mkShell {
          name = "${drv-name-prefix}:development-home";
          buildInputs = import ./framework/users/qd/packages/development {
            inherit pkgs pkgs-stable;
          };
        };

      checks.${common.system}.lint =
        import ./common/lint.nix { inherit common; };

      herculesCI = hci-inputs: {
        onPush = {
          ${framework.hostname}.outputs = {
            development-home =
              self.devShells.${framework.system}.home-development;
            operating-system =
              self.nixosConfigurations.${framework.hostname}.config.system.build.toplevel;
          };
          ${agent.hostname}.outputs = {
            operating-system =
              self.nixosConfigurations.${agent.hostname}.config.system.build.toplevel;
            effects.deployment = import ./agent/effect.nix {
              inherit agent hercules-ci-agent;
              ref = hci-inputs.ref;
              # nixinateApps = self.apps.nixinate;
            };
          };
          dotfiles-lint.outputs.check = self.checks.${common.system}.lint;
        };
      };
    };
}
