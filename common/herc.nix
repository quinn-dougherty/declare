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

    repository.outputs = {

      dotfiles-lint = outputs.checks.${machines.common.system}.lint;

      effects.update-repository = machines.common.pkgs.effects.flakeUpdate {
        enable = true;
        when.dayOfMonth = 1;
        autoMergeMethod = "merge";
      };
    };
  };
}
