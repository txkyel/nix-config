{ pkgs, ... }: {
  programs.rofi.enable = true;
  programs.rofi.package = pkgs.rofi-wayland;
  programs.rofi.plugins = with pkgs; [
    rofi-calc
    rofi-emoji
  ];

  home.file = {
    ".local/bin/rofipower".source = ./rofipower;
  };
}
