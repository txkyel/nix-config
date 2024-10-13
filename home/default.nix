{ pkgs, ... }:
{
    imports = [
        ./session-variables.nix
        ./shell.nix
        ./theme
        ./hyprland
        ./neovim
        ./waybar
        ./anki.nix
        ./browser.nix
        ./games.nix
        ./git.nix
        ./kitty.nix
        ./mpv.nix
        ./programs.nix
    ];
}
