{ ref, agent, nixination }:
with agent.pkgs;
effects.runIf (ref == "refs/heads/main") (effects.mkEffect {
  effectScript = "${nixination.${agent.hostname}.program}";
  inputs = [ nixination.${agent.hostname} flock ];
  # this references secrets.json on your agent
  secretsMap = { "default-ssh" = "default-ssh"; };
  # replace this with the appropriate line from ~/.ssh/known_hosts
  userSetupScript = ''
    writeSSHKey default-ssh ~/.ssh/herc-default-id_rsa
    cat >>~/.ssh/known_hosts <<EOF
    ${with agent; import ./knownhostsfragment.nix { inherit ip; }}
    EOF
  '';

  # replace with hostname or ip address for ssh
  # ssh.destination = agent.ip;
})
