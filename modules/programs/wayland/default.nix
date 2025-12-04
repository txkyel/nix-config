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
  imports = [
    ./niri
    ./hypridle.nix
    ./hyprlock.nix
    ./wlogout.nix
    ./waybar
  ];

  config = mkIf config.profiles.desktop.enable {
    environment.sessionVariables = {
      NIXOS_OZONE_WL = 1;
      QT_QPA_PLATFORM = "wayland;xcb";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };

    # GDM
    services.displayManager.gdm.enable = true;

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };

    hj.packages = with pkgs; [
      (rofi.override {
        plugins = [
          rofi-emoji
          rofi-games
        ];
      })
      swww
      cliphist
      wl-clipboard
      libnotify
      swaynotificationcenter
      brightnessctl
      playerctl
      grim
      slurp
      tesseract
    ];
  };
}
