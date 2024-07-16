{ pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    google-chrome
    qbittorrent
    vesktop
    (mpv.override {
      scripts = [ mpvScripts.mpris ];
    })
  ];
}
