{
  pkgs,
  ...
}:
{
  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      # Enable flakes
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      # https://github.com/NixOS/nixpkgs/issues/293114#issuecomment-2663470083
      build-dir = "/var/tmp";
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
      persistent = true;
      randomizedDelaySec = "10min";
    };
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
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

  # Don't build in tmpfs
  # https://discourse.nixos.org/t/how-do-you-optimize-your-tmp/51956
  systemd.services.nix-daemon.environment.TMPDIR = "/var/tmp";
}
