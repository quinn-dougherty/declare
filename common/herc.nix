{ outputs, machines, agentdeploy }:
hci-inputs: {
  onPush = {
    ${machines.framework.hostname}.outputs = {
      home-shell =
        outputs.devShells.${machines.framework.system}."${machines.framework.hostname}-homeshell";
      operating-system =
        outputs.nixosConfigurations.${machines.framework.hostname}.config.system.build.toplevel;
    };
    ${machines.agent.hostname}.outputs.effects.deployment =
      agentdeploy { ref = hci-inputs.ref; };
    dotfiles-lint.outputs.check = outputs.checks.${machines.common.system}.lint;
  };
}
