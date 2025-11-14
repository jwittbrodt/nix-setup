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

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
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
      nix-vscode-extensions,
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
        modules = [
          ./modules/home
          {
            nixpkgs.overlays = [ nix-vscode-extensions.overlays.default ];
          }
        ];
        extraSpecialArgs = {
          inherit nixgl;
          inherit base16;
          inherit tt-schemes;
        };
      };

      checks = {
        x86_64-linux."home-manager-jonasw@JonasThinkpad" =
          self.homeConfigurations."jonasw@JonasThinkpad".activationPackage;
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
