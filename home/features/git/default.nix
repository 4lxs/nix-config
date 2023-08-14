{ pkgs, ... }: {
  programs = {
    lazygit = {
      enable = true;
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
    git = { # version control
      enable = true;
      delta = {
        enable = true;
        options = {
          navigate = true; # use n and N to move between diff sections
          light = false; # set to true if you're in a terminal w/ a light background color (e.g. the default macOS terminal)
        };
      };
      extraConfig = {
        user.email = "svensek.luka@pm.me";
        user.name = "Svl";
        diff.tool = "nvimdiff";
        merge.tool = "nvimdiff";
        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";
      };
    };
  };
}
