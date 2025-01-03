{
  description = "Build image";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  outputs = { self, nixpkgs }: {
    nixosConfigurations.aarch64Image = nixpkgs.lib.nixosSystem {
      modules = [
        (nixpkgs + "/nixos/modules/installer/sd-card/sd-image-aarch64.nix")
        {
          nixpkgs.hostPlatform.system = "aarch64-linux";
          nixpkgs.buildPlatform.system = "x86_64-linux";
          users.users.nixos = {
            isNormalUser = true;
            extraGroups = [ "wheel" ];
            openssh.authorizedKeys.keys = [
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILzQMaqwP2kxyPglnN+B3/bzE+InGMOKdqZ5K1BI9/HR jonasw@JonasThinkpad-2021-09-23"
            ];
          };
          security.sudo.wheelNeedsPassword = false;
          nix.settings.experimental-features = [ "nix-command" "flakes" ];
          services.openssh = {
            enable = true;
          };
          system.stateVersion = "25.05";
        }
      ];
    };
    images.rpi4 = self.nixosConfigurations.aarch64Image.config.system.build.sdImage;
  };
}
