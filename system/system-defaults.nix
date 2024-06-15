# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Scheduled store optimisation
  nix.optimise.automatic = true;
  # Scheduled garbage collection
  nix.gc = {
    automatic = true;
    options = "--delete-older-than +5";
    persistent = true;
    randomizedDelaySec = "30min";
  };

  # Bootloader.
  boot.loader.timeout = 1;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;

  # Time zone and locale
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  # Configure Xserver
  services.xserver = {
    # Keyboard
    xkb = {
      layout = "us";
      variant = "";
    };

    # Desktop environment
    enable = true;
    windowManager.qtile.enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "Mononoki" ]; })
  ];

  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  
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
  };

  # Packages installed in system profile
  environment.systemPackages = with pkgs; [
    wget
    git
    zsh
    xclip
    xsel
    zip
    unzip
    _7zz
    lm_sensors
    ntfs3g
    brightnessctl
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
