{ ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "terraform"
      "java"
    ];
    userSettings = {
      theme = {
        mode = "dark";
        dark = "One Dark";
        light = "One Light";
      };
      hour_format = "hour24";
      auto_update = false;
      vim_mode = false;
      load_direnv = "shell_hook";
      base_keymap = "VSCode";
      title_bar = {
        show_sign_in = false;
      };
      disable_ai = true;
      telemetry = {
        diagostics = false;
        metrics = false;
      };
    };
  };
}
