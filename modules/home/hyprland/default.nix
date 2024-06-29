{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Clipboard
    cliphist
    wl-clipboard

    # Audio/Video
    brightnessctl
    pamixer
    pavucontrol
    playerctl

    # Notifications
    libnotify
    swaynotificationcenter

    # Hyprland programs
    btop
    cava
    grim
    hyprcursor
    hypridle
    hyprlock
    jq
    kitty
    libsForQt5.qtstyleplugin-kvantum # kvantum
    qt6Packages.qtstyleplugin-kvantum # kvantum
    nwg-look
    polkit_gnome
    pyprland
    qt5ct
    qt6ct
    qt6.qtwayland
    rofi-wayland
    slurp
    swappy
    swww
    waybar
    wlogout
    xdg-user-dirs
    xdg-utils
    yad
  ];

  programs = {
    hyprlock.enable = true;
    waybar.enable = true;
  };
}
