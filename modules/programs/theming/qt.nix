{
  config,
  pkgs,
  lib,
  ...
}:
let
  qt-theme-name = "ColloidDark";
  qt-theme-pkg = pkgs.colloid-kde;
in
{
  config = lib.mkIf config.profiles.desktop.enable {
    environment.sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt6ct";
    };

    hj = {
      files = {
        ".config/qt6ct/qt6ct.conf".text = lib.generators.toINI { } {
          Appearance = {
            icon_theme = "Papirus-Dark";
            standard_dialogs = "xdgdesktopportal";
            custom_palette = false;
            style = "kvantum";
          };
        };
        ".config/Kvantum/Colloid" = {
          source = "${qt-theme-pkg}/share/Kvantum/Colloid";
        };
        ".config/Kvantum/kvantum.kvconfig".text = lib.generators.toINI { } {
          General.theme = qt-theme-name;
        };
      };
      packages = with pkgs; [
        qt-theme-pkg
        qt6Packages.qtstyleplugin-kvantum
        qt6Packages.qt6ct
      ];
    };
  };
}
