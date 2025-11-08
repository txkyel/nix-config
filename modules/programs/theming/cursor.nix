{
  pkgs,
  lib,
  config,
  ...
}:
let
  cursor-theme-name = "Bibata-Modern-Ice";
  cursor-size = "24";
  custom-cursor-theme-pkg = pkgs.symlinkJoin {
    name = "custom-cursor-theme-pkg";
    paths = [ ./custom-icons ];
  };
  cursor-theme-pkgs = [
    pkgs.bibata-cursors
    custom-cursor-theme-pkg
  ];

  gtkCursorConfig = ''
    gtk-cursor-theme-name=${cursor-theme-name}
    gtk-cursor-theme-size=${cursor-size}
  '';

  xcursor-path = [
    "${pkgs.bibata-cursors}/share/icons"
    "${custom-cursor-theme-pkg}/share/icons"
  ];
in
{
  config = lib.mkIf config.profiles.desktop.enable {
    environment.sessionVariables = {
      XCURSOR_THEME = cursor-theme-name;
      XCURSOR_SIZE = cursor-size;
      XCURSOR_PATH = xcursor-path;
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
      packages = cursor-theme-pkgs;
    };

    programs.dconf.profiles.user.databases = [
      {
        lockAll = true;
        settings = {
          "org/gnome/desktop/interface" = {
            cursor-theme = cursor-theme-name;
            cursor-size = lib.gvariant.mkInt32 cursor-size;
          };
        };
      }
    ];
  };
}
