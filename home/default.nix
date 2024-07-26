{ pkgs, ... }:
{
    imports = [
        ./hyprland
        ./neovim
        ./waybar
        ./session-variables.nix
        ./git.nix
        ./gtk.nix
        ./programs.nix
        ./zsh.nix
    ];
}
