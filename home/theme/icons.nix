{
  lib,
  pkgs,
  ...
}:
let
  theme-name = "Icon-Overrides";
  icon-theme-name = "Colloid-Dark";
  icon-theme-pkg = pkgs.colloid-icon-theme;
in
{
  gtk.iconTheme = {
    name = theme-name;
  };

  home.packages = [ icon-theme-pkg ];
  xdg.dataFile."icons/Icon-Overrides/apps" = {
    source = ./app-icons;
    recursive = true;
  };
  xdg.dataFile."icons/Icon-Overrides/index.theme".text =
    let
      sizes = [
        16
        22
        24
        32
        48
        64
        72
        96
        128
        192
        256
      ];
    in
    lib.generators.toINI { } (
      {
        "Icon Theme" = {
          Name = theme-name;
          Inherits = icon-theme-name;
          Directories = lib.concatMapStringsSep "," (size: "apps/" + toString size) sizes;
        };
      }
      // builtins.listToAttrs (
        map (size: {
          name = "apps/" + toString size;
          value = {
            Size = size;
            Context = "Applications";
            Type = "Fixed";
          };
        }) sizes
      )
    );
}
