{ pkgs, ... }:
{
    imports = [
        ./session-variables.nix
        ./shell.nix
        ./hyprland
        ./neovim
        ./waybar
        ./anki.nix
        ./browser.nix
        ./games.nix
        ./git.nix
        ./gtk.nix
        ./kitty.nix
        ./mpv.nix
        ./programs.nix
    ];
}
