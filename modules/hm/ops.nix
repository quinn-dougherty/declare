{ pkgs, ... }: {
  home.packages = with pkgs; [
    seafile-client
    nextcloud-client
    sqlite

    # dropbox-cli
    firefox
    brave
    nyxt
    lynx
    tor-browser-bundle-bin
    tor

    # Media apps and stuff
    obsidian
    qownnotes
    qc
    anki
    libreoffice
    # zotero insecure on oct 30 2023 unstable
    pinta
    obs-studio
    vlc
    # cli infra
    ffmpeg
    djvu2pdf
    youtube-dl
    youtube-tui

    # music
    puredata
    qtractor
  ];
}
