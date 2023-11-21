{ outputs, machines, server-deploy }:
hci-inputs: {
  onPush =
    let qdhomeshell = "${machines.laptop.drv-name-prefix}:homeshell";
    in {
      # TODO: clean this up with `common/lib.nix`
      ${machines.laptop.hostname}.outputs = {
        home-shell = outputs.devShells.${machines.laptop.system}.${qdhomeshell};
        operating-system =
          outputs.nixosConfigurations.${machines.laptop.hostname}.config.system.build.toplevel;
      };

      ${machines.phone.hostname}.outputs =
        let
          phone-uboot =
            outputs.nixosConfigurations.${machines.phone.hostname}.config.mobile.outputs.u-boot;
        in
        {
          os_disk-image = phone-uboot.disk-image;
          os_boot-partition = phone-uboot.boot-partition;
        };

      ${machines.server.hostname}.outputs = with hci-inputs;
        if ref == "refs/heads/main" then {
          effects.deployment = server-deploy { inherit ref; };
        } else {
          operating-system =
            outputs.nixosConfigurations.${machines.server.hostname}.config.system.build.toplevel;
        };

      "${machines.ubuntu.username}@${machines.ubuntu.hostname}:hm".outputs.homeConfig =
        outputs.homeConfigurations.${machines.ubuntu.hostname}.activationPackage;

      developers.outputs =
        builtins.removeAttrs outputs.devShells.${machines.laptop.system}
          [ qdhomeshell ];

      website.outputs = outputs.packages.${machines.common.system}.website;

      format.outputs.check = outputs.checks.${machines.common.system}.formatted;

    };
  onSchedule.auto-update = {
    outputs.effects = machines.common.pkgs.effects.flakeUpdate {
      autoMergeMethod = "merge";
      gitRemote = hci-inputs.primaryRepo.remoteHttpUrl;
    };
    when.dayOfMonth = [ 1 ];
  };
}
