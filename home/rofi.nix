{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (rofi-wayland.override { plugins = [ rofi-emoji-wayland ]; })
  ];

}
