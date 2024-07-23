{ inputs, pkgs, ... }:
{
    nix.settings = {
        # Enable flakes
        experimental-features = [ "nix-command" "flakes" ];
        # Use cachix for hyprland 
        substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    nixpkgs.config.allowUnfree = true;

    # Storage optimisation
    nix.settings.auto-optimise-store = true;
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
        persistent = true;
    };
    # Turn off auto upgrade until hyprland is fixed https://github.com/hyprwm/Hyprland/issues/6973
    #system.autoUpgrade = {
    #    enable = true;
    #    flake = "github:txkyel/nix-config";
    #    flags = [
    #        "--show-trace"
    #        "-L"
    #    ];
    #    persistent = true;
    #};

    # This should match the version you used to install nixos
    system.stateVersion = "24.05";
}
