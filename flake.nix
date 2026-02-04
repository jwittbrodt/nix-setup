{
  description = "My nix setup";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    base16.url = "github:SenchoPens/base16.nix";

    pam-shim = {
      url = "github:Cu3PO42/pam_shim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      pam-shim,
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

      homeConfigurations =
        let
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = {
              allowUnfreePredicate =
                pkg:
                builtins.elem (nixpkgs.lib.getName pkg) [
                  "spotify"
                  "nvidia-x11"
                  "idea"
                ];
              nvidia.acceptLicense = true;
            };
            overlays = [ nix-vscode-extensions.overlays.default ];
          };
          extraSpecialArgs = {
            inherit base16;
            inherit tt-schemes;
          };
        in
        {
          "jonas.wittbrodt@Lenovo-PW03KNKH" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs extraSpecialArgs;
            modules = [
              ./hosts/Lenovo-PW03KNKH.nix
              sops-nix.homeManagerModules.sops
              pam-shim.homeModules.default
              {
                sops.defaultSopsFile = ./secrets/secrets.yaml;
              }
            ];
          };
          "jonasw@JonasThinkpad" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs extraSpecialArgs;
            modules = [
              ./hosts/JonasThinkpad.nix
              sops-nix.homeManagerModules.sops
              pam-shim.homeModules.default
              {
                sops.defaultSopsFile = ./secrets/secrets.yaml;
              }
            ];
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
