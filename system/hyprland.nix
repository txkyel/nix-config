{ inputs, pkgs, host, ... }:
let
    hyprland =
    if (host == "x230") then
        inputs.hyprland.packages.${pkgs.system}.hyprland.override { legacyRenderer = true; }
    else
        inputs.hyprland.packages.${pkgs.system}.hprland;
    xdph = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
in
{
    # TODO: Move back to home-manager module
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    programs.hyprland = {
        enable = true;
        package = hyprland;
        portalPackage = xdph;
        xwayland.enable = true;
    };
    xdg.portal = {
        enable = true;
        wlr.enable = true;
        xdgOpenUsePortal = true;
        extraPortals = with pkgs; [
            xdg-desktop-portal-gtk
        ];
    };

    # Hyprland packages
    environment.systemPackages = with pkgs; [
        # Hyprland utils
        hyprcursor
        hypridle
        hyprlock
        pyprland

        # Appearance
        qt5ct
        qt6ct
        qt6.qtwayland
        libsForQt5.qtstyleplugin-kvantum # kvantum
        qt6Packages.qtstyleplugin-kvantum # kvantum
        nwg-look
        swww

        # Additional window manager utils
        waybar
        wlogout
        xdg-user-dirs
        xdg-utils
        yad

        # Terminal
        kitty
    ];

    programs = {
        hyprlock.enable = true;
        waybar.enable = true;
    };
}
