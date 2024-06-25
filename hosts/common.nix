# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  system.autoUpgrade = {
    enable = true;
    dates = "3:00";
    flake = "github:txkyel/nix-config";
    flags = [
      "-L" # print build logs
    ];
    persistent = true;
  };

  # Scheduled store optimisation
  nix.optimise.automatic = true;
  # Scheduled garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
    persistent = true;
  };

  # Bootloader.
  boot.loader.timeout = 1;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Time zone and locale
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

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

    # Hardware
    lm_sensors
    ntfs3g

    # Files
    git
    zip
    unzip
    _7zz
    curl
    wget

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
