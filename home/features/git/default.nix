{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.cfg.git = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable git integration.";
    };
    lazygit = lib.mkEnableOption "enable git integration.";
    user = lib.mkOption {
      type = lib.types.str;
      default = "svl";
      description = "git global user name";
    };
    email = lib.mkOption {
      type = lib.types.str;
      default = "66408983+4lxs@users.noreply.github.com";
      description = "git global user email";
    };
  };

  config = lib.mkIf config.cfg.git.enable {
    programs = {
      lazygit = {
        enable = config.cfg.git.enable && config.cfg.git.lazygit;
        settings = {
          git = {
            paging = {
              colorArg = "always";
              pager = "${pkgs.delta}/bin/delta --dark --paging=never";
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
      git = {
        # version control
        enable = true;
        delta = {
          enable = true;
          options = {
            navigate = true; # use n and N to move between diff sections
            light = false; # set to true if you're in a terminal w/ a light background color (e.g. the default macOS terminal)
          };
        };
        userEmail = config.cfg.git.email;
        userName = config.cfg.git.user;
        extraConfig = {
          diff.tool = "nvimdiff";
          diff.colorMoved = "default";
          merge.tool = "nvimdiff";
          merge.conflictstyle = "diff3";
          init.defaultBranch = "master";
        };
        aliases = {
          # https://www.gitalias.com/
          s = "status";
          ss = "status -s";
          a = "add";
          c = "commit";
          cv = "commit -v";
          ca = "commit -av";
          ci = "commit -p";
          am = "commit --amend";
          st = "stash";
          stp = "stash pop";

          hist = "log --pretty=format:'%C(yellow)%h%Creset %ad | %s%d [%an]' --graph --date=short";


          d = "diff";

          p = "pull";
          P = "push";
          m = "merge";
          mc = "merge --continue";
          ma = "merge --abort";
          rb = "rebase";
          rba = "rebase --abort";
          rbc = "rebase --continue";
          rbs = "rebase --skip";

          panic = "!tar cvf ../panic.tar *";


          wt-clone =
            let
              wtclonescript = pkgs.writeScriptBin "wt-clone.sh" (lib.readFile ./wt-clone.sh);
            in
            "!sh ${wtclonescript}/bin/wt-clone.sh";
        };
      };
    };
  };
}
