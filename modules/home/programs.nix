{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    google-chrome
    vesktop
    webcord
    (mpv.override {
      scripts = [ mpvScripts.mpris ];
    })
  ];
}
