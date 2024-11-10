{ lib, host, ...}:
{
    imports = [
        ./bluetooth.nix
        ./bootloader.nix
        ./file-manager.nix
        ./fonts.nix
        ./hyprland.nix
        ./localization.nix
        ./network.nix
        ./nixos-configuration.nix
        ./programs.nix
        ./security.nix
        ./services.nix
        ./sound.nix
        ./users.nix
    ] ++ lib.optionals (host != "x230") [
        ./games.nix
    ];
}
