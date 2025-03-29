{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Terminal utils/apps
    btop
    jq
    xdg-user-dirs
    xdg-utils

    # User apps
    obs-studio
    orca-slicer
    qbittorrent
    qalculate-qt
    whatsapp-for-linux
    vesktop
    ytarchive
    yt-dlp
  ];
}
