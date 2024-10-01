{ pkgs, ... }:
{
    home.packages = with pkgs; [
        # Terminal utils/apps
        btop
        cava
        jq
        xdg-user-dirs
        xdg-utils
        libqalculate

        # User apps
        obs-studio
        qbittorrent
        vesktop
        ytarchive
        yt-dlp
    ];
}
