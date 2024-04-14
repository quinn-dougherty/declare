{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = lib.optional (builtins.pathExists ./do-userdata.nix) ./do-userdata.nix ++ [
    "${modulesPath}/virtualisation/digital-ocean-config.nix"
  ];
}
