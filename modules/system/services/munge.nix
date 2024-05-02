{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.munge = {
    enable = true;
    password = "/etc/munge/munge.key";
  };
}
