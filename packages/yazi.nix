{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mediainfo
    ouch
    xdragon
    file-patched
  ];
  environment.sessionVariables = {
    YAZI_FILE_ONE = "${lib.getExe pkgs.file-patched}";
  };
  programs.yazi = {
    enable = true;
    plugins = {
      inherit (pkgs.yaziPlugins) mediainfo ouch;
    };
    settings = {
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

      yazi = {
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
              ];
          };
      };
    };
  };
}
