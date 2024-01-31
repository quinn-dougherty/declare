{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    age
    cachix
    # morph
    act
    heroku
    hci
    arion
    # nixops_unstable # https://github.com/NixOS/nixops/issues/1521
    onionshare
    minicom

    tmate

    # auth
    oauth2c
    oauth2-proxy
  ];
}
