{
  programs.niri.settings.window-rules = [
    {
      geometry-corner-radius = {
        bottom-left = 4.0;
        bottom-right = 4.0;
        top-left = 4.0;
        top-right = 4.0;
      };
      clip-to-geometry = true;
      draw-border-with-background = false;
    }
    {
      matches = [ { title = "^[Pp]icture[- ]in[- ][Pp]icture$"; } ];
      open-floating = true;
    }
  ];
}
