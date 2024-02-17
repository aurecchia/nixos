{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Alessio Aurecchia";
    userEmail = "alessio@aurecchia.ch";

    delta = {
      enable = true;
      options = {
        features = "line-numbers decorations";
      };
    };

    extraConfig = {
      gpg.program = "gpg2";
      rebase = {
        abbreviatedCommands = true;
        autosquash = true;
        autostash = true;
        missingCommitsCheck = "warn";
      };
      alias = {
        amend = "commit -a --amend --no-edit";
        cb = "checkout -b";
        ci = "commit";
        co = "checkout";
        fix = "commit --fixup HEAD";
        lg = "!git --no-pager log --graph --oneline --date=human -n 20";
        lga = "!git lg --exclude '*/renovate/*' --all";
        main = "checkout origin/main";
        pf = "push --force-with-lease origin HEAD";
        pu = "push -u origin";
        re = "rebase -i origin/main --update-refs";
        ru = "remote update --prune";
        s = "status --short --branch --ahead-behind";
        sw = "sw";
        wip = "commit -am \"wip\"";
        gone = "!f() { git fetch --all --prune; git branch -vv | awk '/: gone]/{print $1}' | xargs git branch -D; }; f";

        lgnice = "
          log --graph --abbrev-commit --decorate -n 30 \
          --format=format:'%C(bold blue)%h%C(reset)%C(auto)%d%C(reset)
          %C(auto)%s%C(reset) %C(dim green)(%ae)%C(reset)'";
      };
      commit = {
        verbose = true;
      };
      push = {
        default = "matching";
      };
      pull = {
        ff = "only";
      };
      init = {
        defaultBranch = "main";
      };
      merge = {
        tool = "vimdiff3";
        conflictstyle = "zdiff3";
      };
      "mergetool \"vimdiff3\"" = {
          path = "nvim";
      };
      pager.branch = false;
      mergetool.keepBackup = false;
    };
  };
}
