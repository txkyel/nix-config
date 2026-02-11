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
      qbittorrent
      qalculate-qt
      whatsapp-electron
      vesktop
      compsize
      xdg-user-dirs
      xdg-utils
      godot_4_6
    ];

    environment.sessionVariables = {
      ANKI_WAYLAND = 1;
    };
  };
}
