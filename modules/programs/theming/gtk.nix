{
  config,
  pkgs,
  lib,
  ...
}:
let
  icon-theme-name = "Papirus-Dark";
  icon-theme-pkg = pkgs.papirus-icon-theme;
  gtk-theme-name = "Colloid-Dark";
  gtk-theme-pkg = pkgs.colloid-gtk-theme;

  gtkConfig = ''
    [Settings]
    gtk-theme-name=${gtk-theme-name}
    gtk-icon-theme-name=${icon-theme-name}
  '';
in
{
  config = lib.mkIf config.profiles.desktop.enable {
    environment.sessionVariables.GTK_THEME = gtk-theme-name;

    hj = {
      files = {
        ".local/share/themes/${gtk-theme-name}".source =
          "${gtk-theme-pkg}/usr/share/themes/${gtk-theme-name}";
        ".config/gtk-3.0/settings.ini".text = gtkConfig;
        ".config/gtk-4.0/settings.ini".text = gtkConfig;
      };
      packages = [
        gtk-theme-pkg
        icon-theme-pkg
      ];
    };

    programs.dconf.profiles.user.databases = [
      {
        lockAll = true;
        settings = {
          "org/gnome/desktop/interface" = {
            gtk-theme = gtk-theme-name;
            icon-theme = icon-theme-name;
            color-scheme = "prefer-dark";
          };
          "org/gnome/desktop/privace" = {
            remeber-recent-files = false;
          };
          "org/gtk/settings/file-chooser" = {
            sort-directories-first = true;
          };
        };
      }
    ];
  };
}
