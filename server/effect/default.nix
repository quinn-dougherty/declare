{ ref, server, server-os }:
let
  known-hosts-fragment = with server;
    import ./knownhostsfragment.nix { inherit ip; };
in
with server.pkgs;
hci-effects.runIf (ref == "refs/heads/main") (hci-effects.runNixOS {
  configuration = server-os;
  secretsMap.ssh = "default-ssh";
  userSetupScript = ''
    writeSSHKey
    cat >>~/.ssh/known_hosts <<EOF
    ${known-hosts-fragment}
    EOF
  '';

  ssh.destination = server.ip;
})
