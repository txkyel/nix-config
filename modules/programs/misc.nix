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
    hj.packages = with pkgs; [
      anki-bin
      appimage-run
      obs-studio
      orca-slicer
      qbittorrent-nox
      qalculate-qt
      whatsapp-for-linux
      vesktop
      xdg-user-dirs
      xdg-utils
    ];

    environment.sessionVariables = {
      ANKI_WAYLAND = 1;
    };
  };
}
