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
}
