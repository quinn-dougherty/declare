{
  inputs,
  uptime,
  config,
  ...
}:
let
  keyspath = "${inputs.self}/keys";
in
{
  # time.timeZone = uptime.timezone;
  services.logrotate.enable = true;
  networking.hostName = uptime.hostname;

  secrix.defaultEncryptKeys.${uptime.username} = [
    (builtins.readFile "${keyspath}/id_qd_ed25519.pub")
  ];
  users.users =
    let
      authorizedKeyFiles = [
        "${keyspath}/id_qd_ed25519.pub"
        # "${keyspath}/id_ed25519.pub"
        "${keyspath}/id_server_ed25519.pub"
        "${keyspath}/id_server_rsa_effectsdefault.pub"
      ];
    in
    {
      ${uptime.username} = {
        isNormalUser = true;
        description = uptime.user-fullname;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        hashedPassword = "$6$fgsLAIlN9.8DUV4i$33jT4kJnZapyJVgcrwCCP.cBW3bpHo2/6Uy66lkvjbIkAmnpHQKgiltXhGGwBqCvgJz7LntqppcemV0WrANiI.";
        openssh.authorizedKeys.keyFiles = authorizedKeyFiles;
        # shell = uptime.pkgs.fish;
      };
      root.openssh.authorizedKeys.keyFiles = authorizedKeyFiles;
    };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    git.enable = true;
  };
  system.stateVersion = "24.11";
}
