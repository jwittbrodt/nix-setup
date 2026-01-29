{ pkgs, config, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" ];
      extraConfig = ''
        HYPHEN_INSENSITIVE="true"
        HIST_STAMPS="dd.mm.yyyy"
        DEFAULT_USER=$USER
      '';
    };
    envExtra = ''
      export EDITOR='nano'
    '';
  };
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };
  home.packages = [ pkgs.nix-direnv ];
}
