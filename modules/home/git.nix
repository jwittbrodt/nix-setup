{ config, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        name = "Jonas Wittbrodt";
      };
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
    includes = [
      {
        path = config.sops.templates."personal-github.gitconfig".path;
        condition = "hasconfig:remote.*.url:git@github.com:*/**";
      }
      {
        path = config.sops.templates."personal-gitlab.gitconfig".path;
        condition = "hasconfig:remote.*.url:git@gitlab.com:*/**";
      }
    ];
  };
  sops.secrets."emails/github" = { };
  sops.secrets."emails/gitlab" = { };
  sops.templates."personal-github.gitconfig".content = ''
      [user]
        email = "${config.sops.placeholder."emails/github"}"
  '';
  sops.templates."personal-gitlab.gitconfig".content = ''
      [user]
        email = "${config.sops.placeholder."emails/gitlab"}"
  '';
}
