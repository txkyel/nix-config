{ inputs, pkgs, ... }:
{
  home.packages = [ inputs.pyprland.packages.${pkgs.system}.pyprland ];

  xdg.configFile."hypr/pyprland.toml".text = ''
    [pyprland]

    plugins = [
      "scratchpads",
      "magnify",
    ]

    [scratchpads.term]
    animation = "fromTop"
    command = "kitty --class kitty-dropterm"
    class = "kitty-dropterm"
    size = "75% 60%"
  '';
}
