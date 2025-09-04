{ pkgs, ... }:

{
  imports = [
    ./ssh-server.nix
    ./dns-server.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "de_DE.UTF-8/UTF-8"
    "en_US.UTF-8/UTF-8"
  ];

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  users.users.jonasw = {
    isNormalUser = true;
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    git
  ];

  networking = {
    firewall.enable = true;
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}
