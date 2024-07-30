{ inputs, pkgs, host, ... }:
let
    hyprland =
    if (host == "x230") then
        inputs.hyprland.packages.${pkgs.system}.hyprland.override { legacyRenderer = true; }
    else
        inputs.hyprland.packages.${pkgs.system}.hyprland;
    xdph = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
in
{
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
}
