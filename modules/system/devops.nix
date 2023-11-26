{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    certbot-full
    # python311Packages.certbot-dns-route53
    # awscli2
    cachix
    # morph
    heroku
    hci
    arion
    nixops_unstable # https://github.com/NixOS/nixops/issues/1521
    onionshare
    minicom
    age

    tmate
  ];
}
