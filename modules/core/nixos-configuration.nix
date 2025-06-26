{
  pkgs,
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
      dates = "weekly";
      options = "--delete-older-than 7d";
      persistent = true;
      randomizedDelaySec = "10min";
    };
  };
  nixpkgs.config.allowUnfree = true;

  # Don't build in tmpfs
  # https://discourse.nixos.org/t/how-do-you-optimize-your-tmp/51956
  systemd.services.nix-daemon.environment.TMPDIR = "/var/tmp";
}
