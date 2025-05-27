{ pkgs, ... }:
{
  # https://github.com/Stunkymonkey/nautilus-open-any-terminal/tree/bb0fe33c48770ae9774ad27034152d185def2b67#nixpkgs-nixos-
  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "kitty";
  };

  environment.systemPackages = with pkgs; [
    nautilus
    totem # I hate this but this is how we get audio/video thumbnails
  ];

  services.gvfs.enable = true;

  # mime type associations
  xdg.mime.defaultApplications."inode/directory" = "org.gnome.Nautilus.desktop";
}
