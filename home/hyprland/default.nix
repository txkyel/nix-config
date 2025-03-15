{
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
    ./xdph.nix
  ];

  # TODO: Use files as source instead of linking to repo

  home.file."${config.xdg.configHome}/hypr" = {
    enable = true;
    source = ./hypr;
    recursive = true;
  };

  # Package
  home.packages = with pkgs; [
    # Hyprland utils
    hyprcursor
    hyprlock
    pyprland

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

  programs.hyprlock.enable = true;
}
