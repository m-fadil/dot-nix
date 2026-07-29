{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    nix-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Pinned ke tag rilis, bukan branch: master bergerak tiap hari dan sering breaking.
    # Bump manual: nix flake lock --override-input dms github:AvengeMedia/DankMaterialShell/v1.5.3
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/v1.5.3";
      inputs.nixpkgs.follows = "nix-unstable";
    };

    # Ketiganya WAJIB follows nix-unstable seperti dms — plugin QML yang di-build
    # terhadap quickshell versi lain akan crash saat runtime, bukan gagal saat build.
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nix-unstable";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nix-unstable";
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
