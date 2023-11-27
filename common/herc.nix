{ self, machines, server-deploy }:
hci-inputs:
with machines;
let
  onPush = let
    qdhomeshell = "${laptop.drv-name-prefix}:homeshell";
    packages = self.packages.${machines.common-machines.system};
  in {
    ${laptop.hostname}.outputs = {
      # home-shell = self.devShells.${machines.laptop.system}.${qdhomeshell};
      operating-system = packages.${machines.laptop.hostname};
    };

    ${phone.hostname}.outputs = {
      os_disk-image = packages."${phone.hostname}-disk-image";
      os_boot-partition = packages."${phone.hostname}-boot-partition";
    };

    ${server.hostname}.outputs = with hci-inputs;
      if ref == "refs/heads/main" then {
        effects.deployment = server-deploy { inherit ref; };
      } else {
        operating-system = packages.${machines.server.hostname};
        website = packages.website;
      };

    "${ubuntu.username}@${ubuntu.hostname}:hm".outputs.homeConfiguration =
      self.homeConfigurations.${ubuntu.hostname}.activationPackage;

    developers.outputs = self.devShells.${common-machines.system};

    format.outputs.check = self.checks.${common-machines.system}.formatted;
  };
in {
  ciSystems = [ common-machines.system ];
  inherit onPush;
  onSchedule.auto-update = {
    outputs.effects = common-machines.pkgs.effects.flakeUpdate {
      autoMergeMethod = "merge";
      gitRemote = hci-inputs.primaryRepo.remoteHttpUrl;
    };
    when.dayOfMonth = [ 16 ];
  };
}
