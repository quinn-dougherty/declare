{
  herc-agent = { modulesPath, lib, name, hercules-ci-agent, ... }: {
    imports =
      lib.optional (builtins.pathExists ./do-userdata.nix) ./do-userdata.nix
      ++ [ (modulesPath + "/virtualisation/digital-ocean-config.nix") ]
      ++ [ (import ./configuration.nix { inherit hercules-ci-agent; }) ];

    deployment = {
      targetHost = "64.225.11.209";
      targetUser = "root";
    };

    networking.hostName = name;
  };
}
