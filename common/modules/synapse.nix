{ config, lib, pkgs, ... }:

{
  imports = [ ./postgres.nix ./openssh.nix ./default-packages.nix ];
  services = {

    postgresql.initialScript = pkgs.writeText "backend-initScript" ''
      CREATE USER "matrix-synapse";

      CREATE DATABASE "matrix-synapse"
      ENCODING 'UTF8'
      LC_COLLATE='C'
      LC_CTYPE='C'
      template=template0
      OWNER "matrix-synapse";
    '';
    matrix-synapse = {
      enable = true;
      server_name = "example.com";
      registration_shared_secret = "secret";
      database_type = "psycopg2";
      database_args.database = "matrix-synapse";
      extraConfig = ''
        max_upload_size: "50M"
      '';
    };
  };
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22 # SSH
      8448 # Matrix federation
    ];
  };
}
