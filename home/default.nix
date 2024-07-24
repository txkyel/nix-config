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

    home.packages = with pkgs; [
        btop
        cava
        jq
    ];
}
