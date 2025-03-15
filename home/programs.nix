{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Terminal utils/apps
    btop
    jq
    xdg-user-dirs
    xdg-utils
    libqalculate

    # User apps
    bambu-studio
    obs-studio
    qbittorrent
    whatsapp-for-linux
    vesktop
    ytarchive
    yt-dlp
  ];
}
