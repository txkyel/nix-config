{ pkgs, ... }:
{
    programs.kitty = {
        enable = true;
        font = {
            package = pkgs.fira-code;
            name = "Fira Code SemiBold";
            size = 16;
        };
        settings = {
            background_opacity = "0.5";
            confirm_os_window_close = 0;
            linux_display_server = "auto";
            scrollback_lines = 2000;
            wheel_scroll_min_lines = 1;
            enable_audio_bell = "no";
            window_padding_width = 4;
            selection_foreground = "none";
            selection_background = "none";
            foreground = "#dddddd";
            background = "#000000";
            cursor = "#dddddd";
        };
    };
}
