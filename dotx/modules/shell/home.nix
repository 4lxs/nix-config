_inputs: {
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  libx = config.lib.dotx;
in {
  config = mkMerge [
    (mkIf libx.cfg.shell.utils.enable {
      home = {
        packages = with pkgs; [
          # inputs.nvim-config.packages.${system}.default
          neovim

          ripgrep
          fd
          socat
          unzip
          wget
          jq
          htop
          p7zip
        ];
        sessionVariables = {
          MANPAGER = ''sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'';
        };
      };

      programs = {
        eza.enable = true;
        zoxide = {
          enable = true;
        };
        bat = {
          enable = true;
          config.theme = "Catppuccin Mocha";
          extraPackages = with pkgs.bat-extras; [batman];
        };
        fish.interactiveShellInit = "batman --export-env | source";
        gh = {
          enable = true;
        };
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
      };
    })
    {
      home.shellAliases = mkMerge [
        (mkIf libx.cfg.shell.aliases.enable {
          # TODO: doesn't work in fish
          # vi = "\${EDITOR:-nvim}";
          # vim = "\${EDITOR:-nvim}";
          # nvim = "\${EDITOR:-nvim}";
          vi = "nvim";
          vim = "nvim";
          nvim = "nvim";
          # emacs = "man nvim";

          # TODO: check if tool exists e.g. [ -x "$(command -v exa)" ]
          ls = "eza -al --color=always --group-directories-first";
          tree = "eza --tree";
          entar = "tar -acf";
          untar = "tar -zxvf";
          wget = "wget -c";
          grep = "grep --color=auto";
          cat = "bat";
          # TODO: extract

          ".." = "cd ..";
          "..." = "cd ../..";
          ".2" = "cd ../..";
          ".3" = "cd ../../..";
          ".4" = "cd ../../../..";
          ".5" = "cd ../../../../..";

          # apt = "man nix-env";
          # apt-get = "man nix-env";
        })
        (mkIf libx.cfg.shell.aliases.git {
          g = "git";
          ga = "git add";
          gs = "git status";
          gc = "git commit";
          gp = "git pull";
          gP = "git push";
          gd = "git diff";
          gl =
            "git log --graph --topo-order --decorate --all --boundary --date=short --abbrev-commit "
            + "--pretty=format:'%Cgreen%ad %Cred%h%Creset -%C(yellow)%d%Creset %s %Cblue[%cn]%Creset %Cblue%G?%Creset'";
        })
      ];
    }
  ];
}
