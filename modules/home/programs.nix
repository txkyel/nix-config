{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    google-chrome
    (discord.override {
      withVencord = true;
    })
    (mpv.override {
      scripts = [ mpvScripts.mpris ];
    })
  ];
}
