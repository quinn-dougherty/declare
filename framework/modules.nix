{ framework, nixos-hardware, sops-nix, home-manager, nix-doom-emacs
, hercules-ci-agent }:

[
  (import ./system/configuration.nix { inherit framework; })
  nixos-hardware.nixosModules.framework
  sops-nix.nixosModules.sops
  home-manager.nixosModules.home-manager
  {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.${framework.username} =
        import ./users/qd/home.nix { inherit framework nix-doom-emacs; };
      # extraSpecialArgs.daedalus = daedalus;  # Passes more arguments to home.nix
    };
  }
  ({ config, lib, pkgs, ... }: {
    imports = [ hercules-ci-agent.nixosModules.agent-service ];
    services.hercules-ci-agent.enable = true;
    networking.firewall.allowedTCPPorts = [ 443 ];
  })
]
