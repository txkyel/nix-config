{ pkgs, ... }:
{
  # https://github.com/Stunkymonkey/nautilus-open-any-terminal/tree/bb0fe33c48770ae9774ad27034152d185def2b67#nixpkgs-nixos-
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "kitty";
  };

  environment = {
    sessionVariables.NAUTILUS_4_EXTENSION_DIR = "${pkgs.nautilus-python}/lib/nautilus/extensions-4";
    pathsToLink = [
      "/share/nautilus-python/extensions"
    ];

    systemPackages = with pkgs; [
      nautilus
      nautilus-python
      # video thumbnails
      ffmpegthumbnailer
    ];
  };

  services.gvfs.enable = true;

  # mime type associations
  xdg.mime.defaultApplications."inode/directory" = "org.gnome.Nautilus.desktop";
}
