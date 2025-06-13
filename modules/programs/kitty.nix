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
    environment.sessionVariables = {
      TERMINAL = "kitty";
    };

    hj = {
      packages = with pkgs; [
        kitty
        fira-code
      ];

      files = {
        ".config/kitty/kitty.conf".text = ''
          font_family Fira Code SemiBold
          font_size 16

          shell_integration no-rc

          background #000000
          confirm_os_window_close 0
          cursor #dddddd
          enable_audio_bell no
          foreground #dddddd
          hide_window_decorations yes
          linux_display_server auto
          scrollback_lines 2000
          selection_background none
          selection_foreground none
          wheel_scroll_min_lines 1
          window_padding_width 4
        '';
      };
    };

    xdg.terminal-exec = {
      enable = true;
      settings.default = [ "kitty.desktop" ];
    };
  };
}
