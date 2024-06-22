{ pkgs, ... }: {
  home.packages = with pkgs; [
    libnotify
    dunst
  ];

  services.dunst.enable = true;
  services.dunst.settings = {
    global = {
      show_indicators = false;
    };
  };
}
