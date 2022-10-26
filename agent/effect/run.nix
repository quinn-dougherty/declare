# In this file, unlike effect/default.nix, we utilize the runNixOS command from the effects library.
{ ref, agent, agent-os }:
let
  known-hosts-fragment = with agent;
    import ./knownhostsfragment.nix { inherit ip; };
in with agent.pkgs;
effects.runIf (ref == "refs/heads/main") (effects.runNixOS {
  config = agent-os.config;
  secretsMap.default-ssh = "default-ssh";
  userSetupScript = ''
    KEYNAME=herc-default-id_rsa
    mkdir -p ~/.ssh
    writeSSHKey default-ssh ~/.ssh/$KEYNAME
    chmod 600 ~/.ssh/$KEYNAME
    chmod 644 ~/.ssh/$KEYNAME.pub
    echo "${known-hosts-fragment.one}" >> ~/.ssh/known_hosts
    echo "${known-hosts-fragment.two}" >> ~/.ssh/known_hosts
    chmod 600 ~/.ssh/known_hosts
  '';

  # This is directly from docs, but is causing deployment to break.
  ssh.destination = agent.ip;
})
