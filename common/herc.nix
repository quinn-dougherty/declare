{ outputs, machines, server-deploy }:
hci-inputs: {
  onPush = {
    # TODO: clean this up with `common/lib.nix`
    ${machines.laptop.hostname}.outputs = {
      home-shell =
        outputs.devShells.${machines.laptop.system}."${machines.laptop.drv-name-prefix}homeshell";
      operating-system =
        outputs.nixosConfigurations.${machines.laptop.hostname}.config.system.build.toplevel;
    };

    ${machines.phone.hostname}.outputs = let
      phone-uboot =
        outputs.nixosConfigurations.${machines.phone.hostname}.config.mobile.outputs.u-boot;
    in {
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

    "${machines.ubuntu.hostname}-home".outputs.homeConfig =
      outputs.homeManagerConfigurations.${machines.ubuntu.system}.homemanager;

    ${machines.chat.hostname}.outputs.operating-system =
      outputs.nixosConfigurations.${machines.chat.hostname}.config.system.build.toplevel;

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
