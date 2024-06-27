{ config, pkgs, inputs, ... }:
{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
      persistent = true;
    };
  };
  nixpkgs.config.allowUnfree = true;

  system.autoUpgrade = {
    enable = true;
    flake = "github:txkyel/nix-config";
    flags = [ "-L" ];
    persistent = true;
  };

  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    lm_sensors
    ntfs3g
    zip
    unzip
    _7zz
  ];

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "24.05";
}
