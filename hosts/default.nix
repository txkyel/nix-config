{
  self,
  nixpkgs,
  ...
}:
let
  inherit (self) inputs;

  mkHost =
    name: system:
    nixpkgs.lib.nixosSystem {
      modules = [
        {
          networking.hostName = name;
          nixpkgs.hostPlatform = system;
        }
        ./${name}
        ./../modules
      ];

      specialArgs = {
        host = name;
        username = "kyle";
        inherit inputs;
      };
    };
in
{
  desktop = mkHost "desktop" "x86_64-linux";
  x230 = mkHost "x230" "x86_64-linux";
  m720q = mkHost "m720q" "x86_64-linux";
}
