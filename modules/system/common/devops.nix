{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    age
    cachix
    devenv
    # morph
    act
    heroku
    hci
    arion
    # nixops_unstable # https://github.com/NixOS/nixops/issues/1521
    # onionshare
    # minicom # some bug 2024-12-29

    # networking
    lsof

    tmate

    # auth
    oauth2c
    oauth2-proxy
  ];
}
