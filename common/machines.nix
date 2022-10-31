{ nixpkgs, nixpkgs-stable, python-on-nix, hercules-ci-effects }:
let machines = fromTOML (builtins.readFile ./machines.toml);
in {
  common = machines.common // {
    pkgs = import nixpkgs { system = machines.common.system; };
  };
  framework = rec {
    hostname = machines.framework.hostname;
    username = machines.framework.username;
    user-fullname = machines.framework.user-fullname;
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
      pythonDbusOverlay = (final: prev: {
        python3 = prev.python3.override {
          packageOverrides = self: super: {
            # https://github.com/NixOS/nixpkgs/issues/197408
            dbus-next = super.dbus-next.overridePythonAttrs (old: {
              checkPhase = builtins.replaceStrings [ "not test_peer_interface" ]
                [
                  "not test_peer_interface and not test_tcp_connection_with_forwarding"
                ] old.checkPhase;
            });
          };
        };
      });
    in [ factorioOverlay pythonOnNixOverlay pythonDbusOverlay ];
    config.allowUnfree = true;
    pkgs = import nixpkgs { inherit system overlays config; };
    pkgs-stable = import nixpkgs-stable { inherit system overlays config; };
  };
  agent-digitalocean = rec {
    hostname = machines.agent-digitalocean.hostname;
    username = machines.agent-digitalocean.username;
    user-fullname = machines.agent-digitalocean.user-fullname;
    system = machines.common.system;
    timezone = machines.common.timezone;
    ip = machines.agent-digitalocean.ip;
    volume = machines.agent-digitalocean.volume;
    overlays = [ hercules-ci-effects.overlay ];
    pkgs = import nixpkgs-stable { inherit system overlays; };
  };
  agent-latitude = rec {
    hostname = machines.agent-latitude.hostname;
    username = machines.agent-latitude.username;
    user-fullname = machines.agent-latitude.user-fullname;
    system = machines.common.system;
    timezone = machines.common.timezone;
    ip = machines.agent-latitude.ip;
    overlays = [ hercules-ci-effects.overlay ];
    pkgs = import nixpkgs-stable { inherit system overlays; };
  };
}
