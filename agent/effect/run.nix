# In this file, unlike effect/nixinate.nix, we utilize the runNixOS command from the effects library.
{ ref, agent, agent-os }:
let
  known-hosts-fragment = with agent;
    import ./knownhostsfragment.nix { inherit ip; };
in with agent.pkgs;
effects.runIf (ref == "refs/heads/main") (effects.runNixOS {
  config = agent-os.config;
  secretsMap.ssh = "default-ssh";
  userSetupScript = ''
    # KEYNAME=herc-default-id_rsa
    # mkdir -p ~/.ssh
    writeSSHKey ssh
    # chmod 600 ~/.ssh/$KEYNAME
    # chmod 644 ~/.ssh/$KEYNAME.pub
    cat >>~/.ssh/known_hosts <<EOF
    ${known-hosts-fragment.one}
    ${known-hosts-fragment.two}
    EOF
    # chmod 600 ~/.ssh/known_hosts
  '';

  # This is directly from docs, but is causing deployment to break.
  ssh.destination = agent.ip;
})
