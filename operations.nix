{ self, treefmt-nix, machines, server-deploy }:
with machines;
let
  fmt-module = { ... }: {
    projectRootFile = "flake.nix";
    programs = {
      prettier.enable = true;
      stylish-haskell.enable = true;
      nixfmt.enable = true;
    };
  };
  format =
    let fmtr = treefmt-nix.lib.evalModule common-machines.pkgs fmt-module;
    in fmtr.config.build.wrapper;
  update = hci-inputs: {
    auto-update = {
      outputs.effects = common-machines.pkgs.effects.flakeUpdate {
        autoMergeMethod = "merge";
        gitRemote = hci-inputs.primaryRepo.remoteHttpUrl;
      };
      when.dayOfMonth = [ 1 ];
    };
  };
  onPush = let
    qdhomeshell = "${laptop.drv-name-prefix}:homeshell";
    packages = self.packages.${machines.common-machines.system};
  in {
    ${laptop.hostname}.outputs = {
      operating-system = packages.${machines.laptop.hostname};
      home-configuration =
        self.homeConfigurations."${laptop.username}@${laptop.hostname}".activationPackage;
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

    "${ubuntu.username}@${ubuntu.hostname}:hm".outputs.home-configuration =
      self.homeConfigurations."${ubuntu.username}@${ubuntu.hostname}".activationPackage;

    developers.outputs = self.devShells.${common-machines.system};
  };
in {
  herculesCI = hci-inputs: {
    ciSystems = [ common-machines.system ];
    inherit onPush;
    onSchedule = update hci-inputs;
  };
  formatter.${common-machines.system} = format;
  checks.${common-machines.system}.formatted = format;
}
