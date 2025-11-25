{ pkgs, ... }:

{
  home.packages = with pkgs; [
    opentofu
  ];

  programs.vscode.profiles.default = {
    extensions = with pkgs.nix-vscode-extensions.open-vsx; [
      opentofu.vscode-opentofu
    ];
  };
}
