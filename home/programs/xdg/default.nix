{ pkgs, ... }: {
  home.packages = with pkgs; [
    xdg-utils
  ];

  xdg.userDirs.enable = true;
}
