# this only applies for `morph`. for the herc effect deployment I think the `agent/configuration.nix` should be the move.
{ hercules-ci-agent }: {
  herc-agent = { modulesPath, lib, name, ... }: {
    imports =
      lib.optional (builtins.pathExists ./do-userdata.nix) ./do-userdata.nix
      ++ [
        (modulesPath + "/virtualisation/digital-ocean-config.nix")
      ]
      # ++ [ (import ./configuration.nix { inherit hercules-ci-agent; }) ];
    ;
    deployment = {
      targetHost = "64.225.11.209";
      targetUser = "root";
    };

    networking.hostName = name;
  };
}
