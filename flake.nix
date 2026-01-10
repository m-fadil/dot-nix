{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";

      # Helper function untuk membuat system configuration
      mkSystem = hostname: username: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/${hostname}/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.${username} = import ./home/users/${username}.nix;
          }
        ];
      };
    in {
      nixosConfigurations = {
        # Laptop configuration
        thinkpad = mkSystem "thinkpad" "fadil";

        # Desktop configuration
        # desktop = mkSystem "desktop" "fadil";

        # VM untuk testing
        # vm-test = mkSystem "vm-test" "fadil";
      };
    };
}
