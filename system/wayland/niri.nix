{ inputs, pkgs, ... }:
{
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;

  environment.systemPackages = with pkgs; [
    xwayland-satellite-unstable
  ];
}
