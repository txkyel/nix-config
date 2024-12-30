{ pkgs, pkgs-stable, ... }:
{
    home.packages = (with pkgs; [
        # Terminal utils/apps
        btop
        jq
        xdg-user-dirs
        xdg-utils
        libqalculate

        # User apps
        obs-studio
        qbittorrent
        whatsapp-for-linux
        vesktop
        ytarchive
        yt-dlp
    ]) ++ (with pkgs-stable; [
        bambu-studio
    ]);
}
