{ pkgs, ... }:
{
  hj.packages = with pkgs; [
    btop
    ytarchive
    yt-dlp
  ];
}
