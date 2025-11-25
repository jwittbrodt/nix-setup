{
  pkgs,
  config,
  lib,
  ...
}:

{
  options.my.vscode.userSettings = lib.mkOption {
    description = "VScode user settings as a nested nix attrset.";
    type = lib.types.attrs;
    apply =
      set:
      lib.listToAttrs (
        lib.attrsets.mapAttrsToListRecursive (
          path: value: lib.attrsets.nameValuePair (lib.concatStringsSep "." path) value
        ) set
      );
  };
  config = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        extensions = with pkgs.nix-vscode-extensions.open-vsx; [
          eamodio.gitlens
          naumovs.color-highlight
          streetsidesoftware.code-spell-checker
          tintedtheming.base16-tinted-themes
        ];
        userSettings = config.my.vscode.userSettings;
      };
    };
    my.vscode.userSettings = {
      workbench.colorTheme = "${config.scheme.system}-${config.scheme.slug}";
      editor = {
        fontFamily = lib.strings.concatMapStringsSep ", " (
          x: lib.strings.escapeShellArg x
        ) config.fonts.fontconfig.defaultFonts.monospace;
        fontLigatures = true;
      };
      files = {
        trimTrailingWhitespace = true;
        insertFinalNewline = true;
      };
      window = {
        menuBarVisibility = "toggle";
        zoomLevel = 2;
      };
      gitlens = {
        plusFeatures.enabled = false;
        launchpad.indicator.enabled = false;
      };
    };
  };
}
