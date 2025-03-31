{
  pkgs,
  ...
}:
{
  imports = [
    ./hyprland.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./pyprland.nix
    ./xdph.nix
  ];

  # Package
  home.packages = with pkgs; [
    # Hyprland utils
    hyprcursor

    # Wallpaper daemon
    swww

    # Additional window manager utils
    grimblast
    grim
    slurp
    swappy
    cliphist
    wl-clipboard
    libnotify
    swaynotificationcenter
    wlogout
    brightnessctl
    playerctl
  ];
}
