{ pkgs, pkgs-stable, ... }:
{
    home.packages = (with pkgs; [
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
        whatsapp-for-linux
        ytarchive
        yt-dlp
    ]) ++ (with pkgs-stable; [
        bambu-studio
    ]);
}
