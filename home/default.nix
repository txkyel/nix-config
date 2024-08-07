{ pkgs, ... }:
{
    imports = [
        ./hyprland
        ./neovim
        ./waybar
        ./session-variables.nix
        ./games.nix
        ./git.nix
        ./gtk.nix
        ./programs.nix
        ./shell.nix
    ];
}
