{pkgs, ...}: {
  home.packages = [pkgs.anki-bin];
  home.sessionVariables = {
    ANKI_WAYLAND = 1;
  };
}
