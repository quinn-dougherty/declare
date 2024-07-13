{
  self,
  treefmt-nix,
  machines,
  server-deploy,
  uptime-deploy,
}:
with machines;
let
  fmt-module =
    { ... }:
    {
      projectRootFile = "flake.nix";
      programs = {
        prettier.enable = true;
        stylish-haskell.enable = true;
        nixfmt-rfc-style.enable = true;
      };
    };
  format =
    let
      fmtr = treefmt-nix.lib.evalModule common.pkgs fmt-module;
    in
    fmtr.config.build.wrapper;
  update = hci-inputs: {
    auto-update = {
      outputs.hci-effects = common.pkgs.hci-effects.flakeUpdate {
        autoMergeMethod = "merge";
        gitRemote = hci-inputs.primaryRepo.remoteHttpUrl;
      };
      when.dayOfMonth = [ 1 ];
    };
  };
  jobs =
    hci-inputs:
    let
      qdhomeshell = "${laptop.drv-name-prefix}:homeshell";
      packages = self.packages.${machines.common.system};
    in
    {
      ${laptop.hostname}.outputs = {
        operating-system = packages.${machines.laptop.hostname};
        # home-configuration =
        #  self.homeConfigurations."${laptop.username}@${laptop.hostname}".activationPackage;
      };

      ${phone.hostname}.outputs = {
        os_disk-image = packages."${phone.hostname}-disk-image";
        os_boot-partition = packages."${phone.hostname}-boot-partition";
      };

      ${server.hostname}.outputs =
        with hci-inputs;
        if ref == "refs/heads/main" then
          { effects.deployment = server-deploy { inherit ref; }; }
        else
          {
            operating-system = packages.${machines.server.hostname};
            website = packages.website;
          };

      ${uptime.hostname}.outputs =
        with hci-inputs;
        if ref == "refs/heads/main" then
          { hci-effects.deployment = uptime-deploy { inherit ref; }; }
        else
          { operating-system = packages.${machines.uptime.hostname}; };

      "${ubuntu.drv-name-prefix}:hm".outputs.home-configuration =
        self.homeConfigurations."${ubuntu.drv-name-prefix}".activationPackage;

      developers.outputs = self.devShells.${common.system};
    };
in
{
  herculesCI = hci-inputs: {
    ciSystems = [ common.system ];
    onPush = jobs hci-inputs;
    onSchedule = update hci-inputs;
  };
  formatter.${common.system} = format;
  checks.${common.system}.formatted = format;
}
