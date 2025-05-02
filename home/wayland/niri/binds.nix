{ config, ... }:
{
  programs.niri.settings.binds =
    with config.lib.niri.actions;
    let
      sh = spawn "sh" "-c";
    in
    {
      "Mod+Return".action = spawn "kitty";
      "Mod+Shift+Slash".action = show-hotkey-overlay;
      "Mod+D".action = sh "pkill rofi || rofi -show drun -modi drun,filebrowser,run,window";
      "Ctrl+Alt+P".action = sh "pkill wlogout || wlogout";
      "Ctrl+Alt+L".action = sh "pgrep hyprlock || hyprlock -q";
      "Mod+Q".action = close-window;

      "Print".action = screenshot;
      "Ctrl+Print".action.screenshot-screen = [ ];
      "Alt+Print".action = screenshot-window;
      "Mod+Shift+S".action = screenshot;
      "Mod+P".action.screenshot-screen = [ ];
      "Mod+Ctrl+P".action = screenshot-window;

      "XF86AudioRaiseVolume" = {
        allow-when-locked = true;
        action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";
      };
      "XF86AudioLowerVolume" = {
        allow-when-locked = true;
        action = sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
      };
      "XF86AudioMute" = {
        allow-when-locked = true;
        action = sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };
      "XF86AudioMicMute" = {
        allow-when-locked = true;
        action = sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      };
      "XF86AudioPlay".action = sh "playerctl play-pause";
      "XF86AudioPause".action = sh "playerctl play-pause";
      "XF86AudioNext".action = sh "playerctl next";
      "XF86AudioPrev".action = sh "playerctl previous";
      "XF86AudioStop".action = sh "playerctl stop";

      "XF86MonBrightnessUp".action = sh "brightnessctl set +10%";
      "XF86MonBrightnessDown".action = sh "brightnessctl set +10%";
      "XF86KbdBrightnessDown".action = sh "brightnessctl -d *::kbd_backlight set 30%-";
      "XF86KbdBrightnessUp".action = sh "brightnessctl -d *::kbd_backlight set +30%";

      # Resize column/window
      "Mod+R".action = switch-preset-column-width;
      "Mod+Ctrl+R".action = expand-column-to-available-width;
      "Mod+Shift+R".action = switch-preset-window-height;
      "Mod+Shift+Ctrl+R".action = reset-window-height;
      "Mod+Minus".action = set-column-width "-10%";
      "Mod+Plus".action = set-column-width "-10%";
      "Mod+Ctrl+Minus".action = set-window-height "-10%";
      "Mod+Ctrl+Plus".action = set-window-height "-10%";

      # Fullscreen
      "Mod+F".action = maximize-column;
      "Mod+Ctrl+F".action = fullscreen-window;
      "F11".action = fullscreen-window;
      "Mod+Ctrl+Shift+F".action = toggle-windowed-fullscreen;

      "Mod+C".action = center-column;
      "Mod+V".action = toggle-window-floating;
      "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

      # Focus column/window
      "Mod+H".action = focus-column-left;
      "Mod+J".action = focus-window-down;
      "Mod+K".action = focus-window-up;
      "Mod+L".action = focus-column-right;
      "Alt+Tab".action = focus-window-down-or-column-right;
      "Alt+Shift+Tab".action = focus-window-up-or-column-left;
      "Mod+WheelScrollUp".action = focus-column-left;
      "Mod+WheelScrollDown".action = focus-column-right;

      # Move column/window in workspace
      "Mod+Ctrl+H".action = move-column-left;
      "Mod+Ctrl+J".action = move-window-down;
      "Mod+Ctrl+K".action = move-window-up;
      "Mod+Ctrl+L".action = move-column-right;
      "Mod+Ctrl+WheelScrollUp".action = move-column-left;
      "Mod+Ctrl+WheelScrollDown".action = move-column-right;

      # Focus monitor/workspace
      "Mod+N".action = focus-monitor-previous;
      "Mod+M".action = focus-workspace-down;
      "Mod+Comma".action = focus-workspace-up;
      "Mod+Period".action = focus-monitor-next;
      "Mod+Shift+WheelScrollUp" = {
        cooldown-ms = 150;
        action = focus-workspace-up;
      };
      "Mod+Shift+WheelScrollDown" = {
        cooldown-ms = 150;
        action = focus-workspace-down;
      };

      # Move column to monitor/workspace
      "Mod+Ctrl+N".action = move-column-to-monitor-previous;
      "Mod+Ctrl+M".action = move-column-to-workspace-down;
      "Mod+Ctrl+Comma".action = move-column-to-workspace-up;
      "Mod+Ctrl+Period".action = move-column-to-monitor-next;
      "Mod+Ctrl+Shift+WheelScrollUp" = {
        cooldown-ms = 150;
        action = move-column-to-workspace-up;
      };
      "Mod+Ctrl+Shift+WheelScrollDown" = {
        cooldown-ms = 150;
        action = move-column-to-workspace-down;
      };

      # Workspaces
      "Mod+1".action = focus-workspace 1;
      "Mod+2".action = focus-workspace 2;
      "Mod+3".action = focus-workspace 3;
      "Mod+4".action = focus-workspace 4;
      "Mod+5".action = focus-workspace 5;
      "Mod+6".action = focus-workspace 6;
      "Mod+7".action = focus-workspace 7;
      "Mod+8".action = focus-workspace 8;
      "Mod+9".action = focus-workspace 9;
      # "Mod+Ctrl+1".action = move-column-to-workspace 1;
      # "Mod+Ctrl+2".action = move-column-to-workspace 2;
      # "Mod+Ctrl+3".action = move-column-to-workspace 3;
      # "Mod+Ctrl+4".action = move-column-to-workspace 4;
      # "Mod+Ctrl+5".action = move-column-to-workspace 5;
      # "Mod+Ctrl+6".action = move-column-to-workspace 6;
      # "Mod+Ctrl+7".action = move-column-to-workspace 7;
      # "Mod+Ctrl+8".action = move-column-to-workspace 8;
      # "Mod+Ctrl+9".action = move-column-to-workspace 9;

      "Mod+Escape" = {
        allow-inhibiting = false;
        action = toggle-keyboard-shortcuts-inhibit;
      };
      "Ctrl+Alt+Delete".action = quit;
    };
}
