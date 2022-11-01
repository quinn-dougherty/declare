{ config, lib, pkgs, ... }:

{
  imports =
    (lib.optional (builtins.pathExists ./do-userdata.nix) ./do-userdata.nix);
  services.do-agent.enable = true;
}
