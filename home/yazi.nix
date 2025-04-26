{ lib, pkgs, ... }:
let
  inherit (lib.modules) mkMerge;
in
{
  home.packages = with pkgs; [
    mediainfo
    ouch
    xdragon
  ];
  programs.yazi = {
    enable = true;
    plugins = {
      inherit (pkgs.yaziPlugins) mediainfo ouch;
    };
    keymap = {
      manager = {
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
    settings = mkMerge [
      {
        open.rules = [
          {
            # Upstream bug identifies zip files as application/octet-stream
            # https://github.com/sxyazi/yazi/issues/2075#issuecomment-2557978774
            name = "*.zip";
            use = [
              "extract"
              "reveal"
            ];
          }
        ];
        plugin =
          let
            generateMimePreviewers =
              mimeTypes: plugin:
              map (mime: {
                inherit mime;
                run = plugin;
              }) mimeTypes;

            mediainfoMimeTypes = [
              "audio/*"
              "video/*"
              "image/*"
              "application/subrip"
            ];
          in
          {
            prepend_preloaders = generateMimePreviewers mediainfoMimeTypes "mediainfo";
            prepend_previewers =
              generateMimePreviewers mediainfoMimeTypes "mediainfo"
              ++ generateMimePreviewers [
                "application/*zip"
                "application/x-tar"
                "application/x-bzip2"
                "application/x-7z-compressed"
                "application/x-rar"
                "application/x-xz"
                "application/xz"
              ] "ouch"
              ++ [
                # Upstream bug identifies zip files as application/octet-stream
                # https://github.com/sxyazi/yazi/issues/2075#issuecomment-2557978774
                {
                  name = "*.zip";
                  run = "ouch";
                }
              ];
          };
      }
    ];
  };
}
