{ pkgs, ... }:
{
  hj.packages = with pkgs; [
    btop
    ffmpeg
    ytarchive
    yt-dlp
  ];

  environment.systemPackages = with pkgs; [
    curl
    wget
    zip
    unzip
  ];
}
