{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira-code
    jetbrains-mono
    font-awesome
    terminus_font
    nerd-fonts.jetbrains-mono
  ];
}
