{ pkgs, ... }:
{
  # Required by system and available to root
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    zip
    unzip
    kitty
    qmk-udev-rules
    vial
  ];

  # Set default terminal
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [ "kitty.desktop" ];
    };
  };
}
