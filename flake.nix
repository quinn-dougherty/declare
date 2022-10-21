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
      machines = fromTOML (builtins.readFile ./machines.toml);
      framework = with machines.framework; {
        hostname = hostname;
        username = username;
        system = system;
        timezone = timezone;
        drv-name-prefix = "${username}@${hostname}:";
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
        config.allowUnfree = true;
      };

      pkgs = with framework; import nixpkgs { inherit system overlays config; };
      pkgs-stable = with framework;
        import nixpkgs-stable { inherit system overlays config; };
    in with framework; rec {
      nixosConfigurations.${hostname} = lib.nixosSystem {
        inherit system;
        modules = [
          (import ./system/configuration.nix { inherit framework pkgs; })
          nixos-hardware.nixosModules.framework
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = import ./users/qd/home.nix {
                inherit framework pkgs nix-doom-emacs;
              };
              # extraSpecialArgs.daedalus = daedalus;  # Passes more arguments to home.nix
            };
          }
          ({ config, lib, pkgs, ... }: {
            imports = [ hercules-ci-agent.nixosModules.agent-service ];
            services.hercules-ci-agent.enable = true;
            networking.firewall.allowedTCPPorts = [ 443 ];
          })
        ];
      };

      devShells.${system}.default = pkgs.mkShell {
        name = "${drv-name-prefix}:development-home";
        buildInputs =
          import ./users/qd/packages/development { inherit pkgs pkgs-stable; };
      };

      checks.${system}.default = pkgs.stdenv.mkDerivation {
        name = "${drv-name-prefix}:dotfiles-lint";
        src = ./.;
        buildInputs = with pkgs; [ nixfmt nodePackages.prettier ];
        buildPhase = ''
          for nixfile in $(find $src -type f | grep '[.]nix')
          do
            nixfmt --check $nixfile
          done
          prettier --check $src
        '';
        installPhase = "mkdir -p $out";
      };

      herculesCI.onPush = {
        shell.outputs = self.devShells.${system}.default;
        "${hostname}-os".outputs =
          self.nixosConfigurations.${hostname}.config.system.build.toplevel;
        lint.outputs = self.checks.${system}.default;
      };
    };
}
