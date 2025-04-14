{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Chat
    discord # Due to updates, this is nix-env'd
    chatty
    signal-desktop-bin
    tdesktop
    mattermost-desktop
    element-desktop
    zulip
    slack
    # Email
    tutanota-desktop
    thunderbird
    protonmail-desktop
    # electron-mail
    # Video
    zoom-us
  ];
}
