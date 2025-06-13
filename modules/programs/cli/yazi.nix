{ pkgs, lib, ... }:
let
  tomlFormat = pkgs.formats.toml { };
in
{
  config = {
    environment.sessionVariables = {
      YAZI_FILE_ONE = "${lib.getExe pkgs.file-patched}";
    };

    hj = {
      packages = with pkgs; [
        xdragon
        mediainfo
        ouch
        file-patched
        yazi
      ];

      files = {
        ".config/yazi/plugins/mediainfo.yazi".source = pkgs.yaziPlugins.mediainfo;
        ".config/yazi/plugins/ouch.yazi".source = pkgs.yaziPlugins.ouch;
        ".config/yazi/yazi.toml".source = tomlFormat.generate "yazi-settings" {
          plugin =
            let
              mediaInfoMimeTypes = [
                "{audio,video,image}/*"
                "application/subrip"
              ];
            in
            {
              prepend_preloaders = map (mime: {
                inherit mime;
                run = "mediainfo";
              }) mediaInfoMimeTypes;
              prepend_previewers =
                map (mime: {
                  inherit mime;
                  run = "mediainfo";
                }) mediaInfoMimeTypes
                ++ [
                  {
                    mime = "application/{*zip,x-tar,x-bzip2,x-7z-compressed,x-rar,x-xz,xz}";
                    run = "ouch";
                  }
                ];
            };
        };
        ".config/yazi/keymap.toml".source = tomlFormat.generate "yazi-keymap" {
          mgr = {
            prepend_keymap = [
              {
                on = [ "<C-n>" ];
                run = "shell 'dragon-drop -x -i -T \"$1\"'";
                desc = "Drag and drop files";
              }
              {
                on = [ "C" ];
                run = "plugin ouch";
                desc = "Compress with ouch";
              }
            ];
          };
        };
      };
    };
  };
}
