{ pkgs, ...}:

{
  home.packages = with pkgs; [
    cmake
  ];

  programs.vscode.profiles.default = {
    extensions = with pkgs.nix-vscode-extensions.open-vsx; [
      cheshirekow.cmake-format
      ms-vscode.cmake-tools
      llvm-vs-code-extensions.vscode-clangd
    ];
  };
}
