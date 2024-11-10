{ lib, host, ... }:
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
        ./git.nix
        ./kitty.nix
        ./mpv.nix
        ./programs.nix
    ] ++ lib.optionals (host != "x230") [
        ./games.nix
    ];
}
