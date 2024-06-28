# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  environment.shellAliases = {
    # Color aliases
    "ls" = "ls --color=auto --group-directories-first";
    "grep" = "grep --color=auto";
    "diff" = "diff --color=auto";
    "ip" = "ip -color=auto";
    # Misc
    "ll" = "ls -alF";
    "la" = "ls -A";
  };

  # Packages installed in system profile
  environment.systemPackages = (with pkgs; 
  [
    wl-clipboard
    networkmanagerapplet

    # Audio/Video
    brightnessctl
    pamixer
    pavucontrol
    playerctl

    # Notifications
    libnotify
    swaynotificationcenter

    # Hyprland programs
    ags
    btop
    cava
    cliphist
    gnome.gnome-system-monitor
    grim
    gvfs
    hyprcursor
    hypridle
    hyprlock
    jq
    kitty
    libsForQt5.qtstyleplugin-kvantum # kvantum
    qt6Packages.qtstyleplugin-kvantum # kvantum
    nwg-look
    polkit_gnome
    pyprland
    qt5ct
    qt6ct
    qt6.qtwayland
    rofi-wayland
    slurp
    swappy
    swww
    waybar
    wlogout
    xdg-user-dirs
    xdg-utils
    yad
  ]);

  programs = {
    hyprlock.enable = true;
    waybar.enable = true;
    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      exo
      mousepad
      thunar-archive-plugin
      thunar-volman
      tumbler
    ];
  };
}
