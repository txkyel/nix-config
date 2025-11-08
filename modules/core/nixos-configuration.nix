{
  lib,
  pkgs,
  config,
  ...
}:
{
  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      # Enable flakes
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      # https://github.com/NixOS/nixpkgs/issues/293114#issuecomment-2663470083
      build-dir = "/var/tmp";
      use-xdg-base-directories = true; # Clean home dir
    };

    gc = {
      automatic = true;
      dates = "Mon *-*-* 03:30:00";
      options = "--delete-older-than 14d";
      persistent = true;
      randomizedDelaySec = "10min";
    };
  };
  nixpkgs.config.allowUnfree = true;

  system.autoUpgrade = {
    enable = lib.mkDefault config.profiles.server.enable;
    flake = "github:txkyel/nix-config";
    allowReboot = !config.profiles.desktop.enable; # Only enable when not desktop
    dates = "Mon *-*-* 03:00:00";
    flags = [ "-L" ];
    persistent = true;
    randomizedDelaySec = "10min";
  };

  # Don't build in tmpfs
  # https://discourse.nixos.org/t/how-do-you-optimize-your-tmp/51956
  systemd.services.nix-daemon.environment.TMPDIR = "/var/tmp";
}
