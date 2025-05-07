{
  config,
  pkgs,
  lib,
  ...
}:
{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  home.packages = with pkgs; [
    colloid-kde
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    qt6Packages.qtstyleplugin-kvantum
    qt6Packages.qt6ct
  ];

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = lib.generators.toINI { } {
      General.theme = "ColloidDark";
    };
    "Kvantum" = {
      source = "${pkgs.colloid-kde}/share/Kvantum";
      recursive = true;
    };
    "qt5ct/qt5ct.conf".text = lib.generators.toINI { } {
      Apprearance = {
        custom_palette = false;
        icon_theme = config.gtk.iconTheme.name;
        standard_dialogs = "xdgdesktopportal";
        style = "kvantum";
      };
    };
    "qt6ct/qt6ct.conf".text = config.xdg.configFile."qt5ct/qt5ct.conf".text;
  };
}
