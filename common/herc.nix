{ outputs, machines, agentdeploy }:
hci-inputs: {
  onPush = {
    ${machines.framework.hostname}.outputs = {
      home-shell =
        outputs.devShells.${machines.framework.system}."${machines.framework.hostname}-homeshell";
      operating-system =
        outputs.nixosConfigurations.${machines.framework.hostname}.config.system.build.toplevel;
    };
    ${machines.agent.hostname}.outputs = {
      operating-system =
        outputs.nixosConfigurations.${machines.agent.hostname}.config.system.build.toplevel;
      effects.deploy = agentdeploy {
        ref = hci-inputs.ref;
        nixination = outputs.apps.nixinate;
      };
    };
    dotfiles-lint.outputs.check = outputs.checks.${machines.common.system}.lint;
  };
}
