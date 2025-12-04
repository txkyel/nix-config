{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkIf;
in
{
  config = mkIf (config.profiles.desktop.enable) {
    programs.kdeconnect.enable = true;

    hj.packages = with pkgs; [
      anki-bin
      appimage-run
      obs-studio
      qbittorrent
      qalculate-qt
      whatsapp-electron
      vesktop
      compsize
      xdg-user-dirs
      xdg-utils
    ];

    environment.sessionVariables = {
      ANKI_WAYLAND = 1;
    };
  };
}
