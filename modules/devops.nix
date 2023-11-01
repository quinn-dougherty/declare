{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # nixops # https://github.com/NixOS/nixops/issues/1521
    cachix
    # morph
    heroku
    hci
    arion
    onionshare
    nettools
    netproc
    minicom
  ];
}
