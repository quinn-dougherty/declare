{ outputs, machines, agent-digitalocean-deploy, agent-latitude-deploy }:
hci-inputs: {
  onPush = {
    ${machines.framework.hostname}.outputs = {
      home-shell =
        outputs.devShells.${machines.framework.system}."${machines.framework.hostname}-homeshell";
      operating-system =
        outputs.nixosConfigurations.${machines.framework.hostname}.config.system.build.toplevel;
    };

    ${machines.agent-digitalocean.hostname}.outputs = with hci-inputs;
      if false then { # ref == "refs/heads/main" then {
        effects.deployment = agent-digitalocean-deploy { inherit ref; };
      } else {
        operating-system =
          outputs.nixosConfigurations.${machines.agent-digitalocean.hostname}.config.system.build.toplevel;
      };

    ${machines.agent-latitude.hostname}.outputs = with hci-inputs;
      if ref == "refs/heads/main" then {
        effects.deployment = agent-latitude-deploy { inherit ref; };
      } else {
        operating-system =
          outputs.nixosConfigurations.${machines.agent-latitude.hostname}.config.system.build.toplevel;
      };

    ${machines.chat.hostname}.outputs.operating-system =
      outputs.nixosConfigurations.${machines.chat.hostname}.config.system.build.toplevel;

    dotfiles-lint.outputs.check = outputs.checks.${machines.common.system}.lint;

  };
  onSchedule.auto-update = {
    outputs.effects = machines.common.pkgs.effects.flakeUpdate {
      autoMergeMethod = "merge";
      gitRemote = hci-inputs.primaryRepo.remoteHttpUrl;
    };
    when.dayOfMonth = [ 1 ];
  };
}
