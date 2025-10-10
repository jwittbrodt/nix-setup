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
      plugins = ["git"];
      extraConfig = ''
        HYPHEN_INSENSITIVE="true"
        HIST_STAMPS="dd.mm.yyyy"
        DEFAULT_USER=$USER
      '';
    };
    loginExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        export MOZ_ENABLE_WAYLAND=1
        export XDG_CURRENT_DESKTOP=sway
        export MOZ_DBUS_REMOTE=1
        export _JAVA_AWT_WM_NONREPARENTING=1
        exec sway
      fi
    '';
    envExtra = ''
      export EDITOR='nano'
    '';
  };
}
