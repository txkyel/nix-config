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
  config = mkIf (!config.homelab.enable) {
    hj.packages = with pkgs; [
      # Terminal utils/apps
      btop
      jq
      xdg-user-dirs
      xdg-utils

      # User apps
      appimage-run
      obs-studio
      orca-slicer
      qbittorrent
      qalculate-qt
      whatsapp-for-linux
      vesktop
      ytarchive
      yt-dlp
    ];
  };
}
