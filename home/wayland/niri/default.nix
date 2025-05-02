{
  # xdg.configFile."niri/config.kdl".source = ./config.kdl;
  imports = [
    ./appearance.nix
    ./binds.nix
    ./io.nix
    ./settings.nix
    ./window-rules.nix
  ];
}
