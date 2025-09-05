{
  description = "My nix setup";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations = {
      nixpi1 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [ ./hosts/pi1/configuration.nix ];
      };

      aarch64Image = nixpkgs.lib.nixosSystem {
        modules = [ ./images/aarch64-sd.nix ];
      };
    };

    homeConfigurations."jonasw@JonasThinkpad" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [ ./modules/home-manager ];
    };

    images.rpi4 = self.nixosConfigurations.aarch64Image.config.system.build.sdImage;
  };
}
