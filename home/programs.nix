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
        brave
        google-chrome
        qbittorrent
        vesktop
        (mpv.override { scripts = [ mpvScripts.mpris ]; })
    ];
}
