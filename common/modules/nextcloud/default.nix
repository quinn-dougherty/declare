{ config, lib, pkgs, ... }:

{
  modules = [ ./nextcloud.nix ./nginx.nix ./db.nix ];
}
