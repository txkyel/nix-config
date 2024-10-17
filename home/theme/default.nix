{ config, pkgs, ... }:
let
    cursor-theme-name = "Bibata-Modern-Ice";
    cursor-theme-pkg = pkgs.bibata-cursors;
    icon-theme-name = "Papirus-Dark";
    icon-theme-pkg = pkgs.papirus-icon-theme.override { color = "indigo"; };
    gtk-theme-name = "Layan-Dark-Solid";
    gtk-theme-pkg = pkgs.layan-gtk-theme.overrideAttrs (old: {
        src = pkgs.fetchFromGitHub {
            owner = "vinceliuice";
            repo = "layan-gtk-theme";
            rev = "2133179e31c1958478d3d57c01e844d32e71774e";
            sha256 = "sha256-4m98j9jpx6xri11P0wYdWIhCdVWJX3IbZ7Y4eTObCsE=";
        };
    });
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
    # TODO: fix qt6 theming
    qt.platformTheme.name = "qt6ct";
    qt.style.name = "kvantum";
    home.packages = with pkgs; [
        libsForQt5.qtstyleplugin-kvantum
        qt6Packages.qtstyleplugin-kvantum
    ];
    xdg.configFile = {
        "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=LayanSolidDark";
        "Kvantum" = {
            source = "${./Kvantum}";
            recursive = true;
        };
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
