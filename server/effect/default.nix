{ ref, server, server-os }:
let
  known-hosts-fragment = with server;
    import ./knownhostsfragment.nix { inherit ip; };
in
with server.pkgs;
hci-effects.runIf (ref == "refs/heads/main") (hci-effects.runNixOS {
  configuration = server-os;
  secretsMap.default-ssh = "default-ssh";
  userSetupScript = ''
    writeSSHKey default-ssh
  '';

  ssh.destination = server.ip;
})
