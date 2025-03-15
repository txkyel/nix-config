{ pkgs, ... }:
{
  time.timeZone = "America/Toronto";
  # This currently does not work
  #services.localtimed.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
  ];
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
    enable = true;
    xkb.layout = "us";
  };
}
