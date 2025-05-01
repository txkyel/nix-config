{
  inputs,
  pkgs,
  ...
}:
{
  nix.package = pkgs.nixVersions.latest;
  nix.settings = {
    # Enable flakes
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.ow-mod-man.overlays.default
    (self: super: {
      file-patched = super.file.overrideAttrs (old: {
        patches = old.patches or [ ] ++ [
          (super.fetchpatch {
            url = "https://raw.githubusercontent.com/NixOS/nixpkgs/ae7f8403e0552fababb2110bea2e436283230282/pkgs/tools/misc/file/PR-571-jschleus-Some-zip-files-are-misclassified-as-data.patch";
            hash = "sha256-RVrL7P0Riu3hiLsVvGoGNsJctDplxaF7t+wW/zezdUg=";
          })
        ];
      });
    })
  ];

  # Storage optimisation
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
    persistent = true;
  };
}
