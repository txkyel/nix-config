{
  config,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    packages = null;
    portalPackage = null;

    systemd.variables = ["--all"];

    settings = {
      "$mod" = "SUPER";

      exec-once =
        [
          "swww-daemon --format xrgb"
          "waybar"
          "nm-applet --indicator"
          "blueman-applet"
          "swaync"
          "fcitx5 -d -r"
          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"
          "pypr"
        ]
        ++ lib.optional (config.programs.corectrl.enable) [
          "corectrl --minimize-systray"
        ];
    };
  };
}
