{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
{
  config = mkIf config.profiles.desktop.enable {
    hj = {
      packages = with pkgs; [
        (mpv.override {
          scripts = with pkgs.mpvScripts; [
            modernx-zydezu
            mpris
            thumbfast
          ];
        })
      ];

      files = {
        ".config/mpv/mpv.conf".text = ''
          keep-open=yes
          cursor-autohide=250
        '';

        ".config/mpv/input.conf".text = ''
          MBTN_LEFT cycle pause
        '';

        ".config/mpv/script-opts/modernx.conf".text = ''
          compactmode=no
          showontop=no
        '';
      };
    };

    xdg.mime.defaultApplications = {
      "video/mp4" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
      "video/webm" = "mpv.desktop";
      "video/ogg" = "mpv.desktop";
      "audio/mpeg" = "mpv.desktop";
      "audio/ogg" = "mpv.desktop";
      "audio/flac" = "mpv.desktop";
      "audio/wav" = "mpv.desktop";
      "audio/aac" = "mpv.desktop";
    };
  };
}
