{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nil
    nixfmt
  ];

  programs.vscode.profiles.default = {
    extensions = with pkgs.nix-vscode-extensions.open-vsx; [
      jnoortheen.nix-ide
      mkhl.direnv
    ];
  };
  my.vscode.userSettings = {
    nix = {
      enableLanguageServer = true;
      serverPath = "${pkgs.nil}/bin/nil";
    };
  };
}
