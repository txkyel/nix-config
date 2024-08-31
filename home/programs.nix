{ pkgs, ... }:
{
    home.packages = with pkgs; [
        # Terminal utils/apps
        kitty
        btop
        cava
        jq
        xdg-user-dirs
        xdg-utils
        libqalculate

        # User apps
        qbittorrent
        vesktop
        ytarchive
        yt-dlp
        (mpv.override { scripts = [ mpvScripts.mpris ]; })
    ];
}
