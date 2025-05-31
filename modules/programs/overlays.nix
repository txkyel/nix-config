{ lib, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
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
