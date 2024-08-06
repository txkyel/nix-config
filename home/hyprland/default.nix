{ inputs, pkgs, config, host, ... }:
let
    configPath = "${config.home.homeDirectory}/nix-config/home/hyprland/hypr";
    hyprland =
    if (host == "x230") then
        inputs.hyprland.packages.${pkgs.system}.hyprland.override { legacyRenderer = true; }
    else
        inputs.hyprland.packages.${pkgs.system}.hprland;
    xdph = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
in
{
    # Link config files to project files
    xdg.configFile.hypr.source = config.lib.file.mkOutOfStoreSymlink configPath;

    # Package
    home.packages = with pkgs; [
        # Hyprland utils
        hyprcursor
        hypridle
        hyprlock
        pyprland

        # Theming
        qt5ct
        qt6ct
        qt6.qtwayland
        libsForQt5.qtstyleplugin-kvantum # kvantum
        qt6Packages.qtstyleplugin-kvantum # kvantum
        nwg-look
        swww
        yad

        # Additional window manager utils
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
