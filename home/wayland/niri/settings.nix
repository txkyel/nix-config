{ config, ... }:
{
  programs.niri.settings = {
    # Xwayland
    environment.display = ":0";

    spawn-at-startup =
      with config.lib.niri.actions;
      let
        commands = [
          "swww-daemon --format xrgb"
          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"
          "waybar"
          "nm-applet --indicator"
          "fcitx5 -d -r"
          "xwayland-satellite"
          "corectrl --minimize-systray"
        ];
      in
      map (cmd: {
        command = [
          "sh"
          "-c"
          cmd
        ];
      }) commands;

    screenshot-path = "~/Pictures/Screenshots/Screenshot_%Y-%m-%d_%H-%M-%S.png";

    hotkey-overlay.skip-at-startup = true;

    # No overview setting in flake yet
    # overview = {
    #   zoom = 0.5;
    #   backdrop-color = "#262626";
    #   workspace-shadow = {
    #     softness = 40;
    #     spread = 10;
    #     offset = {
    #       x = 0;
    #       y = 10;
    #     };
    #     color = "#00000050";
    #   };
    # };
  };
}
