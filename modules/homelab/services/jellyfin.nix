{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  service = "jellyfin";
  homelab = config.homelab;
  cfg = homelab.services.${service};
in
{
  options.homelab.services.jellyfin = {
    enable = mkEnableOption "Enable ${service}";
  };

  config = mkIf (homelab.enable && cfg.enable) {
    # https://wiki.nixos.org/wiki/Jellyfin#Intro_Skipper_plugin
    nixpkgs.overlays = with pkgs; [
      (final: prev: {
        jellyfin-web = prev.jellyfin-web.overrideAttrs (
          finalAttrs: previousAttrs: {
            installPhase = ''
              runHook preInstall

              # this is the important line
              sed -i "s#</head>#<script src=\"configurationpage?name=skip-intro-button.js\"></script></head>#" dist/index.html

              mkdir -p $out/share
              cp -a dist $out/share/jellyfin-web

              runHook postInstall
            '';
          }
        );
      })
    ];
    services.jellyfin = {
      enable = true;
      openFirewall = true;
      user = homelab.user;
      group = homelab.group;
    };
  };
}
