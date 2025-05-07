{
  config,
  pkgs,
  ...
}:
let
  cursor-theme-name = "Bibata-Modern-Ice";
  cursor-theme-pkg = pkgs.bibata-cursors;
  icon-theme-name = "Colloid";
  icon-theme-pkg = pkgs.colloid-icon-theme;
  gtk-theme-name = "Colloid-Dark";
  gtk-theme-pkg = pkgs.colloid-gtk-theme;
in
{
  gtk.enable = true;

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
