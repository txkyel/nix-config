# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  # Enable networking
  networking.networkmanager.enable = true;

  # Keyboard
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    fira-code
    jetbrains-mono
    font-awesome
    terminus_font
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kyle = {
    isNormalUser = true;
    home = "/home/kyle";
    description = "kyle";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;
  
  # Packages installed in system profile
  environment.systemPackages = (with pkgs; 
  [
    zsh
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
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    xdg-user-dirs
    xdg-utils
    yad
  ]);

  services = {
    gvfs.enable = true;
    tumbler.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    udev.enable = true;
    envfs.enable = true;
    dbus.enable = true;
    fstrim = {
      enable = true;
      interval = "weekly";
    };
    fwupd.enable = true;
    upower.enable = true;
  };

  security = {
    pam.services.swaylock.text = "auth include login";
    polkit.enable = true;
    rtkit.enable = true;
  };

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };
    xwayland.enable = true;
    hyprlock.enable = true;
    git.enable = true;
    dconf.enable = true;
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

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
  ];

  systemd.services = {
    NetworkManager-wait-online.enable = false;
    power-profiles-daemon = {
      enable = true;
      wantedBy = [ "multi-user.target" ];
    };
  };
}
