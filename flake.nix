{
  description = "My nix setup";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      nixpi1 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [ ./hosts/pi1/configuration.nix ];
      };

      aarch64Image = nixpkgs.lib.nixosSystem {
        modules = [ ./images/aarch64-sd.nix ];
      };
    };

    images.rpi4 = self.nixosConfigurations.aarch64Image.config.system.build.sdImage;
  };
}
