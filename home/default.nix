{ inputs, pkgs, ... }:

{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ./programs ];
  home.username = "kyle";
  home.homeDirectory = "/home/kyle";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  home.packages = with pkgs; [
    brave
    google-chrome
    (pkgs.discord.override {
      withVencord = true;
    })
  ];
}
