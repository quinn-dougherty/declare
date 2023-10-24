{ pkgs }:
with pkgs; [
  # Chat
  discord # Due to updates, this is nix-env'd
  chatty
  signal-desktop
  tdesktop
  mattermost-desktop
  element-desktop
  zulip
  slack
  tutanota-desktop
  thunderbird
  # Video
  zoom-us
]
