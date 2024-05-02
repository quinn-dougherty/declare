{
  ref,
  uptime,
  uptime-os,
}:
let
  known-hosts-fragment = with uptime; import ./knownhostsfragment.nix { inherit ip; };
in
with uptime.pkgs;
hci-effects.runIf false # (ref == "refs/heads/main")
  (
    hci-effects.runNixOS {
      configuration = uptime-os;
      secretsMap.ssh = "default-ssh";
      userSetupScript = ''
        writeSSHKey ssh
        cat >>~/.ssh/known_hosts <<EOF
        ${known-hosts-fragment}
        EOF
      '';

      ssh.destination = uptime.ip;
    }
  )
