{ inputs, pkgs, ... }:
{
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  imports = [ inputs.niri.nixosModules.niri ];
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;

  environment.systemPackages = with pkgs; [
    xwayland-satellite-unstable
  ];
}
