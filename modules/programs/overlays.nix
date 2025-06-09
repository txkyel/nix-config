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
    })
  ];
}
