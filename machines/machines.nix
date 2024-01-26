{ inputs }:
with inputs;
let
  machines = fromTOML (builtins.readFile ./machines.toml);
  config.allowUnfree = true;
  server-onprem-tz = "America/Los_Angeles";
  seafile-overlay = system:
    let nps = nixpkgs-seafile-10.legacyPackages.${system};
    in final: prev: {
      seafile-server = nps.seafile-server;
      seahub = nps.seahub;
    };
  mesa-prev-overlay = final: prev: { mesa = pkgs-stable.mesa; };
  factorio-overlay = final: prev: {
    factorio = prev.factorio.override {
      username = "quinnd";
      # see secrets/default.nix
      token = builtins.readFile "/var/lib/factorio/token";
    };
  };
  drv-name-prefix-Fn = { username, hostname }: "${username}@${hostname}";
  qd = "qd";
  admin = "admin";
in with machines.common; {
  common = {
    inherit system timezone;
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ hercules-ci-effects.overlay ];
    };
    pkgs-stable = import nixpkgs-stable { inherit system; };
  };
  laptop = with machines.laptop; {
    inherit system config timezone hostname user-fullname desktop;
    username = qd;
    drv-name-prefix = drv-name-prefix-Fn {
      username = qd;
      inherit hostname;
    };
    pkgs = import nixpkgs {
      inherit system config;
      overlays = [ factorio-overlay (seafile-overlay system) ];
    };
    pkgs-stable = import nixpkgs-stable { inherit system config; };
  };
  phone = with machines.phone; {
    inherit system config hostname user-fullname timezone;
    username = qd;
    pkgs = import nixpkgs { inherit config system; };
  };
  server = with machines.server; {
    inherit system hostname user-fullname;
    username = admin;
    timezone = server-onprem-tz;
    ip = machines.server.ip;
    static4 = machines.server.static4;
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        hercules-ci-effects.overlay
        (seafile-overlay system)
        factorio-overlay
      ];
    };
  };
  uptime = with machines.uptime; {
    inherit system hostname user-fullname;
    username = admin;
    timezone = server-onprem-tz;
    ip = machines.uptime.ip;
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ hercules-ci-effects.overlay ];
    };
  };
  ubuntu = with machines.ubuntu; {
    inherit system config hostname user-fullname timezone;
    username = qd;
    drv-name-prefix = drv-name-prefix-Fn {
      username = qd;
      inherit hostname;
    };
    pkgs = import nixpkgs {
      inherit system config;
      overlays = [ factorio-overlay ];
    };
  };
}
