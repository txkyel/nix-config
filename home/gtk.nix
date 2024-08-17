{ config, pkgs, ... }:
{
    home.pointerCursor = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
    };

    gtk = {
        enable = true;
        cursorTheme = {
            name = "Bibata-Modern-Ice";
            package = pkgs.bibata-cursors;
            size = 24;
        };
        gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
        gtk3.extraConfig = {
            gtk-application-prefer-dark-theme = 1;
        };
        gtk4.extraConfig = {
            gtk-application-prefer-dark-theme = 1;
        };
    };
    # Desktop dark mode
    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

    # File explorer settings
    dconf.settings."org/gnome/desktop/privacy".remember-recent-files = false;
    dconf.settings."org/gtk/settings/file-chooser".sort-directories-first = true;
}
