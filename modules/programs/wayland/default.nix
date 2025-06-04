{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
{
  imports = [
    ./niri
    ./hypridle.nix
    ./hyprlock.nix
    #./wlogout.nix
  ];

  config = mkIf config.profiles.desktop.enable {
    environment.sessionVariables.NIXOS_OZONE_WL = 1;

    # GDM
    services.displayManager.gdm.enable = true;

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };

    # TODO: migrate to hjem
    hj.packages = with pkgs; [
      swww
      cliphist
      wl-clipboard
      libnotify
      swaynotificationcenter
      brightnessctl
      playerctl
    ];
  };
}
