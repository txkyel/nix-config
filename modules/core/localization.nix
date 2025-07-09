{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf mkMerge;
in
{
  config = mkMerge [
    {
      time.timeZone = lib.mkDefault "America/Toronto";
      services = {
        geoclue2.enable = true;
        localtimed.enable = true;
      };

      i18n.defaultLocale = "en_US.UTF-8";
      i18n.supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "ja_JP.UTF-8/UTF-8"
      ];
    }
    (mkIf config.profiles.desktop.enable {
      i18n.inputMethod = {
        enable = true;
        type = "fcitx5";
        fcitx5.addons = with pkgs; [
          fcitx5-mozc
          fcitx5-gtk
        ];
        # Suppress environment variable warnings
        fcitx5.waylandFrontend = true;
      };
      environment.sessionVariables = {
        GTK_IM_MODULE = "fcitx";
        QT_IM_MODULE = "fcitx";
        SDL_IM_MODULE = "fcitx";
        XMODIFIERS = "@im=fcitx";
      };

      services.xserver = {
        xkb.layout = "us";
      };
    })
  ];
}
