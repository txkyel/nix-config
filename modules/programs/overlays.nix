{ lib, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      # Remove once downgrade is applied to stable
      # https://nixpk.gs/pr-tracker.html?pr=407722
      file-patched = prev.file.overrideAttrs (old: {
        patches = old.patches or [ ] ++ [
          (prev.fetchpatch {
            url = "https://raw.githubusercontent.com/NixOS/nixpkgs/ae7f8403e0552fababb2110bea2e436283230282/pkgs/tools/misc/file/PR-571-jschleus-Some-zip-files-are-misclassified-as-data.patch";
            hash = "sha256-RVrL7P0Riu3hiLsVvGoGNsJctDplxaF7t+wW/zezdUg=";
          })
        ];
      });
      # Unnecessary if the following issue is addressed
      # https://github.com/NixOS/nixpkgs/issues/394395
      vesktop = prev.vesktop.overrideAttrs (oldAttrs: {
        postFixup = ''
          ${oldAttrs.postFixup or ""}
          # Custom wrapper flags
          wrapProgram $out/bin/vesktop \
            ${lib.optionalString final.stdenv.hostPlatform.isLinux ''
              --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--wayland-text-input-version=3}}"
            ''}
        '';
      });
    })
  ];
}
