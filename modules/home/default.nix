{
  base16,
  tt-schemes,
  pkgs,
  config,
  lib,
  ...
}:

{
  imports = [
    ./alacritty.nix
    ./dev
    ./fonts.nix
    ./git.nix
    ./music.nix
    ./ssh-client.nix
    ./utils.nix
    ./window-manager
    ./zsh.nix
    base16.homeManagerModule
  ];

  options = {
    my.isWork = lib.mkOption {
      description = "Whether this host is used for work.";
      type = lib.types.bool;
      default = false;
    };
  };

  config = {
    scheme = "${tt-schemes}/base16/eighties.yaml";

    sops.secrets."tokens/github_public_ro" = { };
    sops.templates."nix-access-tokens.conf" = {
      content = ''
        access-tokens = github.com=${config.sops.placeholder."tokens/github_public_ro"}
      '';
    };
    nix = {
      package = pkgs.nix;
      settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      extraOptions = ''
        !include ${config.sops.templates."nix-access-tokens.conf".path}
      '';
    };

    home.homeDirectory = "/home/${config.home.username}";

    targets.genericLinux = {
      enable = true;
      gpu.enable = true;
      nixGL.packages = null;
    };

    pamShim.enable = true;

    sops.age.keyFile = "${config.home.homeDirectory}/.age/key.txt";

    programs.home-manager.enable = true;

    home.stateVersion = "25.05"; # Please read the comment before changing.
  };
}
