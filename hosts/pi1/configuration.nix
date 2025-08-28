{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos
    ];

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "nixpi1";
  security.sudo.wheelNeedsPassword = false;
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    dates = "02:30";
    flake = "github:jwittbrodt/nix-setup";
  };

  my.sshServer.enable = true;
  my.dnsServer.enable = true;
}
