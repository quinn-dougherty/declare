{ nixpkgs, nixpkgs-stable, python-on-nix, hercules-ci-effects }:
let machines = fromTOML (builtins.readFile ./machines.toml);
in {
  common = machines.common // {
    pkgs = import nixpkgs { system = machines.common.system; };
  };
  framework = rec {
    hostname = machines.framework.hostname;
    username = machines.framework.username;
    system = machines.common.system;
    timezone = machines.common.timezone;
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
    pkgs = import nixpkgs { inherit system overlays config; };
    pkgs-stable = import nixpkgs-stable { inherit system overlays config; };
  };
  agent = rec {
    hostname = machines.agent.hostname;
    username = machines.agent.username;
    system = machines.common.system;
    timezone = machines.common.timezone;
    ip = machines.agent.ip;
    volume = machines.agent.volume;
    overlays = [ hercules-ci-effects.overlay ];
    pkgs = import nixpkgs-stable { inherit system overlays; };
  };
}
