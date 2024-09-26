{ config, pkgs, ... }:
let
    cursor-theme-name = "Bibata-Modern-Ice";
    cursor-theme-pkg = pkgs.bibata-cursors;
    icon-theme-name = "Papirus-Dark";
    icon-theme-pkg = pkgs.catppuccin-papirus-folders.override {
        accent = "blue";
        flavor = "frappe";
    };
    gtk-theme-name = "catppuccin-frappe-blue-standard";
    gtk-theme-pkg = pkgs.catppuccin-gtk.override {
        accents = ["blue"];
        size = "standard";
        variant = "frappe";
    };
    kvantum-theme-name = "Catppuccin-Frappe-Blue";
    kvantum-theme-pkg = pkgs.catppuccin-kvantum.override {
        accent = "Blue";
        variant = "Frappe";
    };
in
{
    # Enable modules
    gtk.enable = true;
    qt.enable = true;

    # Cursor
    gtk.cursorTheme = {
        name = cursor-theme-name;
        package = cursor-theme-pkg;
        size = 24;
    };
    home.pointerCursor = {
        name = cursor-theme-name;
        package = cursor-theme-pkg;
        size = 24;
    };

    # GTK Theme
    gtk.theme = {
        name = gtk-theme-name;
        package = gtk-theme-pkg;
    };
    gtk.iconTheme = {
        name = icon-theme-name;
        package = icon-theme-pkg;
    };

    # QT Theme
    qt.platformTheme.name = "qtct";
    qt.style.name = "kvantum";
    home.packages = [ kvantum-theme-pkg ];
    xdg.configFile = {
        "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" { General.theme = kvantum-theme-name; };
        "Kvantum/${kvantum-theme-name}/${kvantum-theme-name}.kvconfig".source = "${kvantum-theme-pkg}/share/Kvantum/${kvantum-theme-name}/${kvantum-theme-name}.kvconfig";
        "Kvantum/${kvantum-theme-name}/${kvantum-theme-name}.svg".source = "${kvantum-theme-pkg}/share/Kvantum/${kvantum-theme-name}/${kvantum-theme-name}.svg";
    };

    # Desktop dark mode
    dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    gtk = {
        gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
        gtk3.extraConfig = {
            gtk-application-prefer-dark-theme = 1;
        };
        gtk4.extraConfig = {
            gtk-application-prefer-dark-theme = 1;
        };
    };

    # Misc
    # File explorer settings
    dconf.settings."org/gnome/desktop/privacy".remember-recent-files = false;
    dconf.settings."org/gtk/settings/file-chooser".sort-directories-first = true;
}
