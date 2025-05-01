{
  inputs,
  pkgs,
  ...
}:
let
  hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
  xdph = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
in
{
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.niri.enable = true;
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
  programs.hyprland = {
    enable = true;
    package = hyprland;
    portalPackage = xdph;
    xwayland.enable = true;
  };
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
  # GDM
  services.xserver.displayManager.gdm.enable = true;

  # Polkit
  environment.systemPackages = with pkgs; [
    polkit_gnome
  ];
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
