{ pkgs, ... }:
{
  imports = [
    ./hyprland
    ./neovim
    ./git.nix
    ./gtk.nix
    ./programs.nix
    ./zsh.nix
  ];

  home.username = "kyle";
  home.homeDirectory = "/home/kyle";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
