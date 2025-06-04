{ pkgs, ... }:
{
  imports = [
    ./niri.nix
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = 1;

  # GDM
  services.displayManager.gdm.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
