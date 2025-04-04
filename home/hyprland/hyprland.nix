let
  menu = "pkill rofi || rofi -show drun -modi drun,filebrowser,run,window";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;

    systemd.variables = [ "--all" ];

    settings = {
      "$mod" = "SUPER";

      # TODO: Find better way to apply themes or autoricing features
      # Wallust autogenerated variables
      "$background" = "rgb(2D2D30)";
      "$foreground" = "rgb(EFF5EC)";
      "$color0" = "rgb(525255)";
      "$color1" = "rgb(252630)";
      "$color2" = "rgb(424B48)";
      "$color3" = "rgb(415972)";
      "$color4" = "rgb(5F7060)";
      "$color5" = "rgb(637563)";
      "$color6" = "rgb(9DAA96)";
      "$color7" = "rgb(E0E8DB)";
      "$color8" = "rgb(9CA399)";
      "$color9" = "rgb(323340)";
      "$color10" = "rgb(586460)";
      "$color11" = "rgb(567697)";
      "$color12" = "rgb(7E957F)";
      "$color13" = "rgb(849C84)";
      "$color14" = "rgb(D1E3C8)";
      "$color15" = "rgb(E0E8DB)";

      exec-once = [
        "swww-daemon --format xrgb"
        "waybar"
        "nm-applet --indicator"
        "blueman-applet"
        "swaync"
        "fcitx5 -d -r"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "pypr"
        "corectrl --minimize-systray"
      ];

      input = {
        kb_layout = "us";
        repeat_delay = 300;
        follow_mouse = 2;
        float_switch_override_focus = false;
        scroll_factor = 0.8;
        accel_profile = "flat";
        touchpad.natural_scroll = false;
      };

      "device[ploopy-corporation-ploopy-adept-trackball-mouse]" = {
        accel_profile = "adaptive";
        sensitivity = 0;
      };

      general = {
        layout = "master";
        resize_on_border = true;

        border_size = 2;
        gaps_in = 6;
        gaps_out = 8;
        "col.active_border" = "$color0 $color2 $color9 $color12 $color15 90deg";
        "col.inactive_border" = "$background";
      };

      master = {
        new_status = "master";
        new_on_top = 1;
        inherit_fullscreen = true;
      };

      xwayland.force_zero_scaling = true;

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        vfr = true;
        mouse_move_enables_dpms = true;
        enable_swallow = true;
        swallow_regex = "^(kitty)$";
        swallow_exception_regex = "^([Yy]azi.*)$";
        initial_workspace_tracking = 0;
        middle_click_paste = false;
        new_window_takes_over_fullscreen = 1;
        # TODO: Determine how to make this apply to monocle mode only
        exit_window_retains_fullscreen = true;
      };

      decoration = {
        rounding = 4;

        active_opacity = 1.0;
        inactive_opacity = 0.9;
        fullscreen_opacity = 1.0;

        dim_inactive = true;
        dim_strength = 0.1;
        dim_special = 0.8;

        shadow = {
          render_power = 1;
          color = "$color12";
          color_inactive = "0x50000000";
        };
      };

      animations = {
        enabled = true;

        # Animations taken from https://github.com/end-4/dots-hyprland
        bezier = [
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "menu_decel, 0.1, 1, 0, 1"
          "menu_accel, 0.38, 0.04, 1, 0.07"
        ];

        animation = [
          # Animation configs
          "windows, 1, 3, md3_decel, popin 60%"
          "windowsIn, 1, 3, md3_decel, popin 60%"
          "windowsOut, 1, 3, md3_accel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 3, md3_decel"
          "layersIn, 1, 3, menu_decel"
          "layersOut, 1, 1.6, menu_accel"
          "workspaces, 1, 7, menu_decel, slide"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };

      binds = {
        allow_workspace_cycles = true;
        pass_mouse_when_bound = false;
      };

      windowrule = [
        "fullscreenstate 0 2, title:(code-server)" # For work
        "idleinhibit fullscreen, fullscreen:1"
        "workspace 4, class:^(com.obsproject.Studio)$"
        "workspace 7 silent, class:^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$"
        "float, class:(xdg-desktop-portal-gtk)"
        "float, class:^(pavucontrol|org.pulseaudio.pavucontrol)$"
        "float, class:^(qt5ct|qt6ct)$"
        "float, title:(Kvantum Manager)"
        "float, class:^(mpv)$"
        "float, class:^(nm-applet|nm-connection-editor)$"
        "float, class:(\.blueman-manager-wrapped)"
        "float, class:^([Ss]team)$"
        "float, class:^(q[Bb]ittorrent|org.qbittorrent.q[Bb]ittorrent)$"
        "float, class:^(io.github.Qalculate.qalculate-qt)$"
        # Float all windows except the main Anki app
        "float, class:^([Aa]nki)$, title:^((?!User 1 - [Aa]nki).*)$"
        "nodim 1, fullscreen:1"
        "nodim 1, class:^(brave-browser), title:^(.*YouTube.*)"
        "opaque 1, class:^(brave-browser), title:^(.*YouTube.*)"

        "dimaround, class:^(xdg-desktop-portal-gtk)$"
        "dimaround, class:^(polkit-gnome-authentication-agent-1)$"
      ];

      layerrule = [
        "ignorezero, rofi"
        "blur, rofi"
      ];

      bind = [
        # General window management
        "CTRL ALT, Delete, exec, hyprctl dispatch exit 0"
        "$mod, Q, killactive,"
        "ALT F4, Q, killactive,"
        "$mod CTRL, Q, forcekillactive,"
        "$mod, F, exec, hyprctl dispatch fullscreenstate \"$([ $(hyprctl -j activewindow | jq '(.fullscreen)') -lt 2 ] && echo '2 2' || echo '0 0')\""
        "$mod CTRL, F, fullscreenstate, -1 2"
        "$mod, T, togglefloating,"
        "$mod ALT, T, exec, hyprctl dispatch workspaceopt allfloat"
        "CTRL ALT, L, exec, hyprlock -q"
        "CTRL ALT, P, exec, pkill wlogout || wlogout"
        "ALT, Tab, cyclenext"
        "ALT, Tab, bringactivetotop"
        "$mod CTRL, left, movewindow, l"
        "$mod CTRL, right, movewindow, r"
        "$mod CTRL, up, movewindow, u"
        "$mod CTRL, down, movewindow, d"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Monitor management
        "$mod, comma, focusmonitor, -1"
        "$mod, period, focusmonitor, +1"

        # Workspace management
        "$mod SHIFT, U, movetoworkspace, special"
        "$mod, U, togglespecialworkspace,"

        # Switch workspaces with mainMod + [0-9]
        "$mod, code:10, exec, workspace-qtile 1"
        "$mod, code:11, exec, workspace-qtile 2"
        "$mod, code:12, exec, workspace-qtile 3"
        "$mod, code:13, exec, workspace-qtile 4"
        "$mod, code:14, exec, workspace-qtile 5"
        "$mod, code:15, exec, workspace-qtile 6"
        "$mod, code:16, exec, workspace-qtile 7"
        "$mod, code:17, exec, workspace-qtile 8"
        "$mod, code:18, exec, workspace-qtile 9"
        "$mod, code:19, exec, workspace-qtile 10"

        # Move active window and follow to workspace mainMod + SHIFT [0-9]
        "$mod SHIFT, code:10, exec, workspace-qtile 1 switch"
        "$mod SHIFT, code:11, exec, workspace-qtile 2 switch"
        "$mod SHIFT, code:12, exec, workspace-qtile 3 switch"
        "$mod SHIFT, code:13, exec, workspace-qtile 4 switch"
        "$mod SHIFT, code:14, exec, workspace-qtile 5 switch"
        "$mod SHIFT, code:15, exec, workspace-qtile 6 switch"
        "$mod SHIFT, code:16, exec, workspace-qtile 7 switch"
        "$mod SHIFT, code:17, exec, workspace-qtile 8 switch"
        "$mod SHIFT, code:18, exec, workspace-qtile 9 switch"
        "$mod SHIFT, code:19, exec, workspace-qtile 10 switch"

        # Move active window to a workspace silently mainMod + CTRL [0-9]
        "$mod CTRL, code:10, movetoworkspacesilent, 1"
        "$mod CTRL, code:11, movetoworkspacesilent, 2"
        "$mod CTRL, code:12, movetoworkspacesilent, 3"
        "$mod CTRL, code:13, movetoworkspacesilent, 4"
        "$mod CTRL, code:14, movetoworkspacesilent, 5"
        "$mod CTRL, code:15, movetoworkspacesilent, 6"
        "$mod CTRL, code:16, movetoworkspacesilent, 7"
        "$mod CTRL, code:17, movetoworkspacesilent, 8"
        "$mod CTRL, code:18, movetoworkspacesilent, 9"
        "$mod CTRL, code:19, movetoworkspacesilent, 10"

        # Runtime theming
        "$mod, W, exec, wallpaper"
        "$mod, B, exec, pkill waybar || waybar"

        # Applications
        "$mod, Return, exec, kitty"
        "$mod SHIFT, N, exec, swaync-client -t -sw"
        "$mod ALT, C, exec, qalculate-qt"

        # rofi
        "$mod, D, exec, ${menu}"
        "$mod ALT, E, exec, pkill rofi || rofi -show emoji -modi emoji -config ~/.config/rofi/config-emoji.rasi"
        "$mod ALT, V, exec, clip-menu"

        # pyprland
        "$mod SHIFT, Return, exec, pypr toggle term"
        "$mod, Z, exec, pypr zoom"

        # screenshots
        ", Print, exec, screenshot --now"
        "$mod CTRL, Print, exec, screenshot --monitor"
        "$mod SHIFT, S, exec, screenshot --area"

        # Master Layout
        "$mod, J, layoutmsg, cyclenext"
        "$mod, J, bringactivetotop"
        "$mod, K, layoutmsg, cycleprev"
        "$mod, K, bringactivetotop"
        "$mod CTRL, J, layoutmsg, swapnext"
        "$mod CTRL, K, layoutmsg, swapprev"
        "$mod, HOME, layoutmsg, focusmaster"
        "$mod, M, fullscreenstate, 1 -1" # Monocle-ish layout
      ];

      # Special keys
      binde = [
        ", xf86KbdBrightnessDown, exec, brightnessctl -d *::kbd_backlight set 30%-"
        ", xf86KbdBrightnessUp, exec, brightnessctl -d *::kbd_backlight set +30%"
        ", xf86MonBrightnessDown, exec, brightnessctl set 10%-"
        ", xf86MonBrightnessUp, exec, brightnessctl set +10%"
      ];
      bindel = [
        ", xf86audioraisevolume, exec, volume --inc"
        ", xf86audiolowervolume, exec, volume --dec"
      ];
      bindl = [
        ", xf86AudioMicMute, exec, volume --toggle-mic #mute mic"
        ", xf86audiomute, exec, volume --toggle"
        ", xf86Sleep, exec, systemctl suspend  # sleep button "
        ", xf86Rfkill, exec, airplane-mode"
        ", xf86AudioPlayPause, exec, playerctl play-pause"
        ", xf86AudioPause, exec, playerctl play-pause"
        ", xf86AudioPlay, exec, playerctl play-pause"
        ", xf86AudioNext, exec, playerctl next"
        ", xf86AudioPrev, exec, playerctl previous"
        ", xf86audiostop, exec, playerctl stop"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
