{
  pkgs,
  ...
}:
{
  imports = [
    ./hyprland.nix
    ./pyprland.nix
    ./xdph.nix
  ];

  # Package
  home.packages = with pkgs; [
    # Hyprland utils
    hyprcursor

    # Additional window manager utils
    grimblast
    slurp
    swappy
  ];
}
