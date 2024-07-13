{ pkgs, ... }:
{
  home.packages = with pkgs; [
    seafile-client
    # seahub
    # nextcloud-client
    sqlite

    # Browsers # firefox comes with fresh installations, so is omitted.
    brave
    nyxt
    lynx
    tor-browser-bundle-bin
    tor
    opera

    # Bitwarden
    bitwarden
    bitwarden-cli
    bitwarden-menu

    # Media apps and stuff
    # obsidian
    qownnotes
    qc
    anki
    remnote
    libreoffice
    # zotero insecure on oct 30 2023 unstable
    inkscape
    pinta
    obs-studio
    vlc
    # cli infra
    ix
    ffmpeg
    djvu2pdf
    youtube-dl
    youtube-tui

    # music
    puredata
    qtractor
    spotify
  ];
}
