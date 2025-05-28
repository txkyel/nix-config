{
  imports = [
    ./options.nix
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.05"; # Did you read the comment?
  services.openssh.enable = true;
}
