{ pkgs, ... }:

{
  programs.vscode.profiles.default = {
    extensions = with pkgs.nix-vscode-extensions.open-vsx; [
      mtxr.sqltools
    ];
  };
}
