{ inputs }:
with inputs;
let
  machines = fromTOML (builtins.readFile ./machines.toml);
  server-onprem-tz = "America/Los_Angeles";
  seafile-overlay = system:
    let nps = nixpkgs-seafile-10.legacyPackages.${system};
    in final: prev: {
      seafile-server = nps.seafile-server;
      seahub = nps.seahub;
    };
  mesa-prev-overlay = final: prev: { mesa = pkgs-stable.mesa; };
  factorio-overlay = final: prev: {
    factorio = pkgs.factorio.override {
      username = "quinnd";
      # see secrets/default.nix
      token = builtins.readFile "/var/lib/factorio/token";
    };
  };
  drv-name-prefix-Fn = { username, hostname }: "${username}@${hostname}";
  qd = "qd";
  admin = "admin";
in {
  common = with machines.common; {
    inherit system timezone;
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ hercules-ci-effects.overlay ];
    };
    pkgs-stable = import nixpkgs-stable { inherit system; };
  };
  laptop = rec {
    hostname = machines.laptop.hostname;
    username = qd;
    user-fullname = machines.laptop.user-fullname;
    system = machines.common.system;
    timezone = machines.common.timezone;
    desktop = machines.laptop.desktop;
    drv-name-prefix = drv-name-prefix-Fn { inherit username hostname; };
    config.allowUnfree = true;
    pkgs = import nixpkgs {
      inherit system config;
      overlays = [ factorio-overlay ];
    };
    pkgs-stable = import nixpkgs-stable { inherit system config; };
  };
  phone = rec {
    hostname = machines.phone.hostname;
    username = qd;
    user-fullname = machines.phone.user-fullname;
    system = machines.phone.system;
    timezone = machines.common.timezone;
    config.allowUnfree = true;
    pkgs = import nixpkgs { inherit system config; };
  };
  server = rec {
    hostname = machines.server.hostname;
    username = admin;
    user-fullname = machines.server.user-fullname;
    system = machines.common.system;
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
  ubuntu = rec {
    hostname = machines.ubuntu.hostname;
    username = qd;
    user-fullname = machines.ubuntu.user-fullname;
    system = machines.common.system;
    timezone = machines.common.timezone;
    drv-name-prefix = drv-name-prefix-Fn { inherit username hostname; };
    config.allowUnfree = true;
    pkgs = import nixpkgs {
      inherit system config;
      overlays = [ factorio-overlay ];
    };
  };
}
