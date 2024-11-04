{ pkgs, config, ... }:
let
    configPath = "${config.home.homeDirectory}/nix-config/home/hyprland/hypr";
in
{
    # TODO: Use files as source instead of linking to repo
    # Link config files to project files
    xdg.configFile.hypr.source = config.lib.file.mkOutOfStoreSymlink configPath;

    # Package
    home.packages = with pkgs; [
        # Hyprland utils
        hyprcursor
        hypridle
        hyprlock
# Disabled until aiofiles dependency issue is resolved
#        pyprland

        # Theming
        swww
        wallust

        # Additional window manager utils
        grimblast
        grim
        slurp
        swappy
        cliphist
        wl-clipboard
        libnotify
        swaynotificationcenter
        rofi-wayland
        wlogout
        yad # Used for keybind hints
        brightnessctl
        playerctl
    ];

    programs.hyprlock.enable = true;
}
