{ ref, agent }:
with agent.pkgs;
effects.runIf (ref == "refs/heads/main") (effects.mkEffect {
  effectScript = ''
    nix run .#apps.nixinate.${agent.hostname}
  '';

  # this references secrets.json on your agent
  secretsMap = { "ssh" = "default-ssh"; };
  # replace this with the appropriate line from ~/.ssh/known_hosts
  userSetupScript = ''
    writeSSHKey ssh
    cat >>~/.ssh/known_hosts <<EOF
    ${agent.ip} ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINgl+QJ+NlZG22AASEkWHv+ihYdLzpLMUzbNG/MJb7ei
    EOF
  '';

  # replace with hostname or ip address for ssh
  # ssh.destination = agent.ip;
})
