# Defunct, in favor of `effects.runNixOS`
{ ref, server, nixination }:
let
  known-hosts-fragment = with server;
    import ./knownhostsfragment.nix { inherit ip; };
in
with server.pkgs;
hci-effects.runIf (ref == "refs/heads/main") (hci-effects.mkEffect {
  effectScript = ''
    ${nixination.${server.hostname}.program}
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
    echo "${known-hosts-fragment}" >> ~/.ssh/known_hosts
    chmod 600 ~/.ssh/known_hosts
  '';

  # This is directly from docs, but is causing deployment to break.
  # ssh.destination = server.ip;
})
