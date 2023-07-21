{ ref, agent, agent-os }:
let
  known-hosts-fragment = with agent;
    import ./knownhostsfragment.nix { inherit ip; };
in with agent.pkgs;
hci-effects.runIf (ref == "refs/heads/main") (hci-effects.runNixOS {
  config = agent-os.config;
  secretsMap.ssh = "default-ssh";
  userSetupScript = ''
    writeSSHKey ssh
    cat >>~/.ssh/known_hosts <<EOF
    ${known-hosts-fragment}
    EOF
  '';

  # This is directly from docs, but is causing deployment to break.
  ssh.destination = agent.ip;
})
