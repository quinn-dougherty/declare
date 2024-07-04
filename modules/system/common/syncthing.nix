{
  machine,
  inputs,
  config,
  lib,
  pkgs,
  ...
}:

{
  services.syncthing = {
    enable = true;
    settings = {
      folders = {
        "${machine.username}" = {
          # DON'T PUT THIS IN common/default.nix AS IS
          path = "/home/${machine.username}";
          devices = [ machine.hostname ];
        };
        versioning = {
          type = "staggered";
          params = {
            cleanInterval = "3600";
            maxAge = "15768000";
          };
        };
      };
      devices = {
        "${machine.hostname}" = {
          name = "${machine.hostname}";
          addresses = [ "dynamic" ];
        };
      };
    };
  };
}
