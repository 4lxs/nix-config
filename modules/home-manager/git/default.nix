{ pkgs, lib, ... }:
let
  wtclonescript =
    pkgs.writeScriptBin "wt-clone.sh" (lib.readFile ./wt-clone.sh);
in {
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
    git = {
      # version control
      enable = true;
      delta = {
        enable = true;
        options = {
          navigate = true; # use n and N to move between diff sections
          light =
            false; # set to true if you're in a terminal w/ a light background color (e.g. the default macOS terminal)
        };
      };
      userEmail = "svensek.luka@pm.me";
      userName = "Svl";
      extraConfig = {
        diff.tool = "nvimdiff";
        diff.colorMoved = "default";
        merge.tool = "nvimdiff";
        merge.conflictstyle = "diff3";
        init.defaultBranch = "master";
      };
      aliases = { wt-clone = "!sh ${wtclonescript}/bin/wt-clone.sh"; };
    };
  };
}
