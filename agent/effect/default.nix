{ ref, agent, nixination }:
let
  known-hosts-fragment = with agent;
    import ./knownhostsfragment.nix { inherit ip; };
in with agent.pkgs;
effects.runIf (ref == "refs/heads/main") (effects.mkEffect {
  effectScript = ''
    ${nixination.${agent.hostname}.program}
  '';
  secretsMap.default-ssh = "default-ssh";
  userSetupScript = ''
    mkdir -p pathaugment
    cp ${openssh}/bin/ssh pathaugment/ssh
    cp ${util-linux}/bin/flock pathaugment/flock
    export PATH=$PATH:pathaugment

    KEYNAME=herc-default-id_rsa
    mkdir -p ~/.ssh
    writeSSHKey default-ssh ~/.ssh/$KEYNAME
    chmod 600 ~/.ssh/$KEYNAME
    chmod 644 ~/.ssh/$KEYNAME.pub
    echo "${known-hosts-fragment.one}" >> ~/.ssh/known_hosts
    echo "${known-hosts-fragment.two}" >> ~/.ssh/known_hosts
  '';

  # This is directly from docs, but is causing deployment to break.
  # ssh.destination = agent.ip;
})
