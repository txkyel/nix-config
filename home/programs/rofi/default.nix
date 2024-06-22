{ pkgs, ... }: {
  programs.rofi.enable = true;
  programs.rofi.plugins = with pkgs; [
    rofi-calc
    rofi-emoji
  ];

  home.file = {
    ".local/bin/rofipower".source = ./rofipower;
  };
}
