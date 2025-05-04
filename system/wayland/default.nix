{ pkgs, ... }:
{
  imports = [
    ./hyprland.nix
    ./niri.nix
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = 1;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
