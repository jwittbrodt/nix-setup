{
  pkgs,
  config,
  lib,
  ...
}:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions = with pkgs.nix-vscode-extensions.open-vsx; [
        eamodio.gitlens
        jnoortheen.nix-ide
        mkhl.direnv
        naumovs.color-highlight
        streetsidesoftware.code-spell-checker
        tintedtheming.base16-tinted-themes
      ];
      userSettings =
        let
          flattenIntoJson =
            set:
            lib.listToAttrs (
              lib.attrsets.mapAttrsToListRecursive (
                path: value: lib.attrsets.nameValuePair (lib.concatStringsSep "." path) value
              ) set
            );
        in
        flattenIntoJson {
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
          nix.enableLanguageServer = true;
        };
    };
  };
}
