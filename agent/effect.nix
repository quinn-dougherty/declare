{ ref, agent, hercules-ci-agent }:
with agent.pkgs;
let herc-droplet-host = "64.225.11.209";
in effects.runIf (ref == "refs/heads/main") (effects.mkEffect {
  effectScript = ''
    nix run .#apps.nixinate.${agent.hostname}
  '';

  # this references secrets.json on your agent
  secretsMap = { "ssh" = "default-ssh"; };
  # replace this with the appropriate line from ~/.ssh/known_hosts
  userSetupScript = ''
    writeSSHKey ssh
    cat >>~/.ssh/known_hosts <<EOF
    ${herc-droplet-host} ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMKFa4HNszRLl2G9m3+qkNDiQ3EPMZtdBlowBrb+jkfA
    EOF
  '';

  # replace with hostname or ip address for ssh
  # ssh.destination = herc-droplet-host;

})
