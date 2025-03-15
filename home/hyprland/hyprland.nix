{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    packages = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;

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
