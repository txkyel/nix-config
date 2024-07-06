{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    google-chrome
    vesktop
    (mpv.override {
      scripts = [ mpvScripts.mpris ];
    })
  ];
}
