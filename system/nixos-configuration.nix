{
  inputs,
  pkgs,
  ...
}:
{
  nix.package = pkgs.nixVersions.latest;
  nix.settings = {
    # Enable flakes
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    # Use cachix for hyprland
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ inputs.ow-mod-man.overlays.default ];

  # Storage optimisation
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
    persistent = true;
  };

  # This should match the version you used to install nixos
  system.stateVersion = "24.05";
}
