{
  programs.niri.settings = {
    input = {
      keyboard = {
        xkb.layout = "us";
        repeat-delay = 300;
      };
      mouse = {
        accel-speed = -0.5;
        accel-profile = "flat";
        scroll-method = "no-scroll";
      };
    };

    outputs = {
      "DP-3" = {
        mode = {
          width = 2560;
          height = 1440;
          refresh = 144.972;
        };
      };
    };
  };
}
