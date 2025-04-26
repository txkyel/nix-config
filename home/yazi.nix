{ pkgs, ... }:
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
    settings = {
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
          mediainfoMimeTypes = [
            "{audio,video,image}/*"
            "application/subrip"
          ];
        in
        {
          prepend_preloaders = map (mime: {
            inherit mime;
            run = "mediainfo";
          }) mediainfoMimeTypes;
          prepend_previewers =
            map (mime: {
              inherit mime;
              run = "mediainfo";
            }) mediainfoMimeTypes
            ++ [
              {
                mime = "application/{*zip,x-tar,x-bzip2,x-7z-compressed,x-rar,x-xz,xz}";
                run = "ouch";
              }
              # Upstream bug identifies zip files as application/octet-stream
              # https://github.com/sxyazi/yazi/issues/2075#issuecomment-2557978774
              {
                name = "*.zip";
                run = "ouch";
              }
            ];
        };
    };
  };
}
