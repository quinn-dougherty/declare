{
  inputs,
  system,
  modpath,
  username,
  desktop,
  ...
}:

[
  {
    programs.firefox.enable = true;
    home = {
      username = username;
      homeDirectory = "/home/" + username;
      stateVersion = "24.05";
    };
  }
  # "${modpath}/mail"
  "${modpath}/git.nix"
  "${modpath}/vim.nix"
  "${modpath}/codium.nix"
  # "${modpath}/code.nix"
  "${modpath}/comms.nix"
  "${modpath}/ops.nix"
  "${modpath}/cursor.nix"
  "${modpath}/direnv.nix"
  # "${modpath}/games.nix"
  { services = if desktop == "xmonad" then import ./xservices.nix else { }; }
]
