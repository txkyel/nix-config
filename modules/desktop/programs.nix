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
    alacritty
    via
    vial
  ];

  hardware.keyboard.qmk.enable = true;

  # Set default terminal
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [ "kitty.desktop" ];
    };
  };
}
