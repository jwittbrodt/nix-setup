{
  description = "My nix setup";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:nix-community/nixgl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    base16.url = "github:SenchoPens/base16.nix";

    tt-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixgl,
      base16,
      tt-schemes,
    }:
    {
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
        modules = [ ./modules/home ];
        extraSpecialArgs = {
          inherit nixgl;
          inherit base16;
          inherit tt-schemes;
        };
      };

      images.rpi4 = self.nixosConfigurations.aarch64Image.config.system.build.sdImage;

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
