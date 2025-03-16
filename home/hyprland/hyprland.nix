let
  menu = "pkill rofi || rofi -show drun -modi drun,filebrowser,run,window";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    packages = null;
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
        sensitivity = -0.25;
      };

      # Figure out how to make this device specific
      monitors = [
        "DP-3, 2560x1440@144, 1920x0, 1"
        "HDMI-A-1, 1920x1080, 0x0, 1"
      ];

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
        swallow_exception_regex = "^(Yazi.*)$";
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

      windowrulesv2 = [
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
        "float, class:^(org.corectrl.CoreCtrl)$"
        "float, class:^(org.gabmus.envision.Devel)$"
        "float, class:^(io.github.Qalculate.qalculate-qt)$"
        # Float all windows except the main Anki app
        "float, class:^([Aa]nki)$, title:^((?!User 1 - [Aa]nki).*)$"
        "nodim 1, fullscreen:1"
        "nodim 1, class:^(brave-browser), title:^(.*YouTube.*)"
        "opaque 1, class:^(brave-browser), title:^(.*YouTube.*)"
      ];

      layerrule = [
        "ignorezero, rofi"
        "blur, rofi"
      ];

      bind = [
        # Applications
        "$mod, Return, exec, kitty"
        "$mod ALT, C, exec, qalculate-qt"

        # rofi
        "$mod, D, exec, ${menu}"

        # pyprland
        "$mod SHIFT, Return, exec, pypr toggle term"
        "$mod, Z, exec, pypr zoom"
      ];
    };
  };
}
