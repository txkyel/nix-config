{
  pkgs,
  ...
}:
{
  imports = [
    ./hyprland
    ./niri
    ./waybar
    ./wlogout
  ];

  home.packages = with pkgs; [
    swww
    cliphist
    wl-clipboard
    libnotify
    swaynotificationcenter
    brightnessctl
    playerctl
  ];
}
