{
  pkgs,
  ...
}:
{
  imports = [
    ./niri
    ./hypridle.nix
    ./hyprlock.nix
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
