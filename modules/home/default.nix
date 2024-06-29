{ pkgs, ... }:
{
  imports = [
    ./hyprland
    ./neovim
    ./git.nix
    ./zsh.nix
  ];

  home.username = "kyle";
  home.homeDirectory = "/home/kyle";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    brave
    google-chrome
    (discord.override {
      withVencord = true;
    })
  ];
}
