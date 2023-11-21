{ self, machines, server-deploy }:
hci-inputs:
let
  onPush =
    let
      qdhomeshell = "${machines.laptop.drv-name-prefix}:homeshell";
      packages = self.packages.${machines.common.system};
    in
    {
      ciSystems = [ machines.common.system ];
      ${machines.laptop.hostname}.outputs = {
        # home-shell = self.devShells.${machines.laptop.system}.${qdhomeshell};
        operating-system = packages.${machines.laptop.hostname};
      };

      ${machines.phone.hostname}.outputs =
        {
          os_disk-image = packages."${machines.phone.hostname}-disk-image";
          os_boot-partition = packages."${machines.phone.hostname}-boot-partition";
        };

      ${machines.server.hostname}.outputs = with hci-inputs;
        if ref == "refs/heads/main" then {
          effects.deployment = server-deploy { inherit ref; };
        } else {
          operating-system =
            packages.${machines.server.hostname};
          website = packages.website;
        };

      "${machines.ubuntu.username}@${machines.ubuntu.hostname}:hm".outputs.homeConfig =
        self.homeConfigurations.${machines.ubuntu.hostname}.activationPackage;

      developers.outputs = self.devShells.${machines.common.system};

      format.outputs.check = self.checks.${machines.common.system}.formatted;

    };
in
{
  inherit onPush;
  onSchedule.auto-update = {
    outputs.effects = machines.common.pkgs.effects.flakeUpdate {
      autoMergeMethod = "merge";
      gitRemote = hci-inputs.primaryRepo.remoteHttpUrl;
    };
    when.dayOfMonth = [ 16 ];
  };
}
