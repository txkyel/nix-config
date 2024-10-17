{ pkgs, config, ... }:
let
    configPath = "${config.home.homeDirectory}/nix-config/home/hyprland/hypr";
in
{
    # TODO: Use files as source instead of linking to repo
    # Link config files to project files
    xdg.configFile.hypr.source = config.lib.file.mkOutOfStoreSymlink configPath;

    # Package
    home.packages = with pkgs; [
        # Hyprland utils
        hyprcursor
        hypridle
        hyprlock
        pyprland

        # Theming
        swww
        wallust

        # Additional window manager utils
        grimblast
        grim
        slurp
        swappy
        (cliphist.overrideAttrs (_old: {
          src = pkgs.fetchFromGitHub {
            owner = "sentriz";
            repo = "cliphist";
            rev = "c49dcd26168f704324d90d23b9381f39c30572bd";
            sha256 = "sha256-2mn55DeF8Yxq5jwQAjAcvZAwAg+pZ4BkEitP6S2N0HY=";
          };
          vendorHash = "sha256-M5n7/QWQ5POWE4hSCMa0+GOVhEDCOILYqkSYIGoy/l0=";
        }))
        wl-clipboard
        libnotify
        swaynotificationcenter
        rofi-wayland
        wlogout
        yad # Used for keybind hints
        brightnessctl
        playerctl
    ];

    programs.hyprlock.enable = true;
}
