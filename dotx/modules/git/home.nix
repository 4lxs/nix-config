_inputs: {
  config,
  lib,
  pkgs,
  ...
}: let
  libx = config.lib.dotx;
in {
  config = lib.mkIf libx.cfg.git.enable {
    programs = {
      git = {
        enable = true;
        delta = {
          enable = true;
          options = {
            navigate = true;
          };
        };

        userEmail = libx.cfg.user.email;
        userName = libx.cfg.user.name;
        extraConfig = {
          core.editor = libx.cfg.editor;
          core.pager = "${pkgs.delta}/bin/delta";
          push.autoSetupRemote = true;
          merge.conflictstyle = "diff3";
          init.defaultBranch = "master";
        };

        aliases = {
          # https://www.gitalias.com/
          c = "commit --verbose";
          ca = "commit --all --verbose";
          ci = "commit --patch";

          am = "commit --amend";
          amne = "commit --amend --no-edit";

          st = "stash";
          stp = "stash pop";

          hist = "log --pretty=format:'%C(yellow)%h%Creset %ad | %s%d [%an]' --graph --date=short";

          ds = "diff --staged";
          p = "log --patch";

          lfp =
            "log --first-parent --graph --topo-order --decorate --all --boundary --date=short --abbrev-commit "
            + "--pretty=format:'%Cgreen%ad %Cred%h%Creset -%C(yellow)%d%Creset %s %Cblue[%cn]%Creset %Cblue%G?%Creset'";
          lr =
            "log --reverse --topo-order --decorate --all --boundary --date=short --abbrev-commit "
            + "--pretty=format:'%Cgreen%ad %Cred%h%Creset -%C(yellow)%d%Creset %s %Cblue[%cn]%Creset %Cblue%G?%Creset'";

          m = "merge";
          mc = "merge --continue";
          ma = "merge --abort";

          rb = "rebase";
          rbi = "rebase --inteactive";
          rba = "rebase --abort";
          rbc = "rebase --continue";
          rbs = "rebase --skip";

          # wanted to use it, but git broke so much, it failed. idk
          panic = "!tar cvf ../panic.tar *";

          wt-clone = let
            wtclonescript = pkgs.writeScriptBin "wt-clone.sh" (lib.readFile ./wt-clone.sh);
          in "!sh ${wtclonescript}/bin/wt-clone.sh";
        };
      };

      lazygit = {
        enable = true;
        settings = {
          git = {
            paging = {
              colorArg = "always";
              pager = "${pkgs.delta}/bin/delta";
            };
            log = {
              order = "topo-order";
              showGraph = "when-maximised";
              showWholeGraph = false;
            };
            autoFetch = true;
            autoRefresh = true;
          };
        };
      };
    };
  };
}
