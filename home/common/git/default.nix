{ config, lib, pkgs, environment, ... }:

{
  programs.git = {
    enable = true;
    userName = "Alessio Aurecchia";
    userEmail = "alessio@aurecchia.ch";

    includes = [
      { condition = "gitdir/i:valora/";
        contents = {
          user = {
            name = "Alessio Aurecchia";
            email = "alessio.aurecchia@valora.com";
          };
        };
      }
    ];

    delta = {
      enable = true;
      options = {
        features = "line-numbers decorations";
        navigate = true;
        whitespace-error-style = "22 reverse";
        decorations = {
          zero-syle = "auto";
          commit-decoration-style = "bold ul";
          file-decoration-style = "none";
          hunk-header-decoration-style = "none";
          # minus-style = "syntax dim #240000";
          # minus-emph-style = "normal #60090A";
          # plus-style = "syntax #001600";
          # plus-emph-style = "normal #004000";
          # file-style = "gray ul";
          # line-numbers-left-format = "{nm:^4}┊";
          # line-numbers-left-style = "#333333";
          # line-numbers-right-style = "#333333";
        };
      };
    };

    extraConfig = {
      gpg.program = "gpg2";
      rebase = {
        abbreviateCommands = true;
        autosQuash = true;
        autosTash = true;
        udpateRefs = true;
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
        sw = "switch";
        sh = "show --reverse origin/main..@";
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
        templateDir = "~/.config/git/template/";
      };
      merge = {
        tool = "nvimdiff";
        conflictstyle = "zdiff3";
      };
      mergetool = {
        keepBackup = false;
        vimdiff.layout = "MERGED+(LOCAL,BASE,REMOTE/MERGED)";
      };
      pager.branch = false;
      advice.detachedHead = false;
    };
  };

  home.file.".config/git/template/hooks/post-commit" = {
    source = ./template/hooks/post-commit;
  };
  home.file.".config/git/template/hooks/post-checkout" = {
    source = ./template/hooks/post-checkout;
  };
  home.file.".config/git/template/hooks/post-merge" = {
    source = ./template/hooks/post-merge;
  };
  home.file.".config/git/template/hooks/post-rewrite" = {
    source = ./template/hooks/post-rewrite;
  };
  home.file.".config/git/template/hooks/pre-push" = {
    source = ./template/hooks/pre-push;
  };
  home.file.".config/git/template/hooks/update-submodules" = {
    source = ./template/hooks/update-submodules;
  };
}
