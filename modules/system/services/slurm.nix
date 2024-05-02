{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ./munge.nix ];
  services.slurm = {
    server.enable = true;
    client.enable = true;
    extraConfig = ''
      SlurmctldHost=${config.networking.hostName}
      NodeName=TODO
    '';
  };
}
