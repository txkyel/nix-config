{ pkgs, ... }:
{
  hj.packages = with pkgs; [
    btop
    ffmpeg
    ytarchive
    yt-dlp
  ];
}
