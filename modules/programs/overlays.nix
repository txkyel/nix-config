{ lib, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
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

      # Holdover fix for mpv https://github.com/NixOS/nixpkgs/issues/412382#issuecomment-2924903019
      # https://github.com/NixOS/nixpkgs/pull/412889
      mpv-unwrapped = prev.mpv-unwrapped.override {
        libplacebo = final.libplacebo-mpv;
      };
      libplacebo-mpv =
        let
          version = "7.349.0";
        in
        prev.libplacebo.overrideAttrs (old: {
          inherit version;
          src = prev.fetchFromGitLab {
            domain = "code.videolan.org";
            owner = "videolan";
            repo = "libplacebo";
            rev = "v${version}";
            hash = "sha256-mIjQvc7SRjE1Orb2BkHK+K1TcRQvzj2oUOCUT4DzIuA=";
          };
        });
    })

  ];
}
