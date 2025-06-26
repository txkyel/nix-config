{
  pkgs,
  lib,
  config,
  ...
}:
let
  cursor-theme-name = "Bibata-Modern-Ice";
  cursor-theme-pkg = pkgs.bibata-cursors;

  gtkCursorConfig = ''
    gtk-cursor-theme-name=${cursor-theme-name}
    gtk-cursor-theme-size=24
  '';
in
{
  config = lib.mkIf config.profiles.desktop.enable {
    environment.sessionVariables = {
      XCURSOR_THEME = cursor-theme-name;
      XCURSOR_SIZE = 24;
      XCURSOR_PATH = [
        "${cursor-theme-pkg}/share/icons"
      ];
    };

    hj = {
      files = {
        ".config/gtk-3.0/settings.ini".text = lib.mkAfter gtkCursorConfig;
        ".config/gtk-4.0/settings.ini".text = lib.mkAfter gtkCursorConfig;
        ".local/share/icons/default/index.theme".text = ''
          [Icon Theme]
          Inherits=${cursor-theme-name}
        '';
      };
      packages = [ cursor-theme-pkg ];
    };

    programs.dconf.profiles.user.databases = [
      {
        lockAll = true;
        settings = {
          "org/gnome/desktop/interface" = {
            cursor-theme = cursor-theme-name;
            cursor-size = lib.gvariant.mkInt32 24;
          };
        };
      }
    ];
  };
}
