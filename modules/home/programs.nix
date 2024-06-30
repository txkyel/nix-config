{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    google-chrome
    mpv
    (discord.override {
      withVencord = true;
    })
  ];
}
