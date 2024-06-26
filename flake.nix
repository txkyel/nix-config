{
  description = "My flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kmonad = {
      url = "github:kmonad/kmonad?submodules=1&dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland inputs
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };

    wallust.url = "git+https://codeberg.org/explosion-mental/wallust?ref=dev";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in
  {
    nixosConfigurations = {
      x230 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { host = "x230"; inherit inputs; };
        modules = [
          ./hosts/x230
        ];
      };
      vm = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { host = "vm"; inherit inputs; };
        modules = [
          ./hosts/vm
        ];
      };
    };

    homeConfigurations = {
      kyle = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          # TODO: Determine how to make modules host independent
          ./modules/home
        ];
      };
    };
  };
}
