{ pkgs, ... }: {
  home.packages = with pkgs; [
    waybar
    xdg-desktop-portal-hyprland
  ];

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mode, mouse:273, resizewindow"
    ];
    bind = [
      # Actions
      "$mod, O, exec, rofi -show drun"
      "$mod, RETURN, exec, alacritty"
      "$mod, Q, killactive,"
      "$mod SHIFT, Q, exit"
      "$mod, T, togglefloating,"
      "$mod, F, fullscreen,"

      # Move focus with hjkl
      "$mod, H, movefocus, l"
      "$mod, J, movefocus, d"
      "$mod, K, movefocus, u"
      "$mod, L, movefocus, r"

      # Mouse binds
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"
    ] ++ (
      # Workspaces
      builtins.concatLists (
        builtins.genList (
          x: let
            ws = let
              c = (x + 1) / 10;
            in
            builtins.toString (x + 1 - (c * 10));
          in
          [
            "$mod, ${ws}, workspace, ${toString(x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString(x + 1)}"
          ]
        )
        10
      )
    );
  };
}
