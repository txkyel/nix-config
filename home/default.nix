{ pkgs, ... }:
{
    imports = [
        ./hyprland
        ./neovim
        ./waybar
        ./git.nix
        ./gtk.nix
        ./programs.nix
        ./zsh.nix
    ];
}
