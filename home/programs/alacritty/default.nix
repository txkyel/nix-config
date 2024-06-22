{ pkgs, ... }: {
  home.packages = with pkgs; [
    alacritty
  ];

  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    window.padding = {
      x = 8;
      y = 8;
    };
  };
}
