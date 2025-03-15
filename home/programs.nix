{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Terminal utils/apps
    btop
    jq
    xdg-user-dirs
    xdg-utils

    # User apps
    bambu-studio
    obs-studio
    qbittorrent
    qalculate-qt
    whatsapp-for-linux
    vesktop
    ytarchive
    yt-dlp
  ];
}
