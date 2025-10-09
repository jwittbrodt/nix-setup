{ pkgs, config, ... }:

{
  programs.git = {
    enable = true;
    userName = "Jonas Wittbrodt";
    userEmail = "36197762+jwittbrodt@users.noreply.github.com";
    lfs.enable = true;
    extraConfig = {
      core.editor = "nano";
      column.ui = "auto";
      branch.sort = "-committerdate";
      tag.sort = "version:refname";
      init.defaultBranch = "main";
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };
      push.autoSetupRemote = true;
      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };
      help.autocorrect = "prompt";
      commit.verbose = true;
      rerere = {
        enabled = true;
        autoupdate = true;
      };
      rebase = {
        autoSquash = true;
        updateRefs = true;
        autoStash = true;
      };
      merge.conflictstyle = "zdiff3";
      pull.rebase = true;
    };
  };
}
