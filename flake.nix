{
  description = "My nix setup";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
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

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      base16,
      tt-schemes,
      nix-vscode-extensions,
      sops-nix,
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
          sops-nix.homeManagerModules.sops
          {
            sops.defaultSopsFile = ./secrets/secrets.yaml;
            nixpkgs.overlays = [ nix-vscode-extensions.overlays.default ];
          }
        ];
        extraSpecialArgs = {
          inherit base16;
          inherit tt-schemes;
        };
      };

      checks = {
        x86_64-linux."home-manager-jonasw@JonasThinkpad" =
          self.homeConfigurations."jonasw@JonasThinkpad".activationPackage;
      };

      devShells.x86_64-linux.default =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in
        pkgs.mkShell {
          packages = with pkgs; [
            sops
            ssh-to-age
            age
          ];
        };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
