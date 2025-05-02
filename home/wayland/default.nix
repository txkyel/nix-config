{
  pkgs,
  ...
}:
{
  imports = [
    ./hyprland
    ./niri
    ./waybar
    ./wlogout.nix
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
