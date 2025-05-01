{
  pkgs,
  ...
}:
{
  imports = [
    ./hyprland
    ./niri
    ./waybar
  ];

  home.packages = with pkgs; [
    swww
    cliphist
    wl-clipboard
    libnotify
    swaynotificationcenter
    wlogout
    brightnessctl
    playerctl
  ];
}
