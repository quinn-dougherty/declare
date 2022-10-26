{ ref, agent, nixination }:
with agent.pkgs;
effects.runIf (ref == "refs/heads/main") (effects.mkEffect {
  effectScript = ''
    mkdir -p pathaugment
    cp ${openssh}/bin/ssh pathaugment/ssh
    cp ${util-linux}/bin/flock pathaugment/flock
    export PATH=$PATH:pathaugment
    ${nixination.${agent.hostname}.program}
  '';
  # inputs = [ util-linux ];
  secretsMap.default-ssh = "default-ssh";
  userSetupScript = ''
    writeSSHKey default-ssh ~/.ssh/herc-default-id_rsa
    cat >>~/.ssh/known_hosts <<EOF
    ${with agent; import ./knownhostsfragment.nix { inherit ip; }}
    EOF
  '';

  # This is directly from docs, but is causing deployment to break.
  # ssh.destination = agent.ip;
})
