{ pkgs, ... }:
{
    imports = [
        ./hyprland
        ./neovim
        ./waybar
        ./session-variables.nix
        ./browser.nix
        ./games.nix
        ./git.nix
        ./gtk.nix
        ./mpv.nix
        ./programs.nix
        ./shell.nix
    ];
}
