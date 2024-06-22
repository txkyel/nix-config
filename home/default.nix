{ inputs, config, pkgs, ... }:

{
  # TODO: Figure out how to link to global nixpkgs instead of setting option for instanced nixpkgs
  nixpkgs.config.allowUnfree = true;
  home.username = "kyle";
  home.homeDirectory = "/home/kyle";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Enable xdg
  xdg.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home manager package configs
  imports = [
    ./programs
    ./wm
  ];

  home.packages = with pkgs; [
    brave
    google-chrome
    maim
    pavucontrol
    picom
    playerctl
    vlc
    (pkgs.discord.override {
      withVencord = true;
    })
  ];
}
