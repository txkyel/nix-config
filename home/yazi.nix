{ pkgs, ... }:
{
  home.packages = with pkgs; [ xdragon ];
  programs.yazi = {
    enable = true;
    keymap = {
      manager = {
        prepend_keymap = [
          {
            on = [ "<C-n>" ];
            run = "shell 'dragon -x -i -T \"$1\"'";
            desc = "Drag and drop files";
          }
        ];
      };
    };
  };
}
