{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    nix-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-unstable, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";

      pkgsUnstable = import nix-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      # Helper function untuk membuat system configuration
      mkSystem = hostname: username: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs pkgsUnstable;
        };
        modules = [
          ./hosts/${hostname}/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = {
              inherit inputs pkgsUnstable;
            };
            home-manager.users.${username} = import ./pkgs/users/${username}.nix;
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
