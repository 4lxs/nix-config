{
  pkgs,
  lib,
  config,
  ...
}: {
  options.cfg.zsh = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "enable zsh shell";
    };
  };

  config = lib.mkIf config.cfg.zsh.enable {
    programs.zsh = {
      enable = true;
      autocd = true;
      enableCompletion = false;
      defaultKeymap = "viins";
      dotDir = ".config/zsh";
      history = {
        share = false;
        ignoreDups = true;
        save = 100000000;
        size = 1000000000;
      };

      initExtra = ''
        # load work stuff
        [ -f ~/.aliasrc ] && source ~/.aliasrc
        [ -x "$(command -v kubectl)" ] && source <(kubectl completion zsh)
        [ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
        [ -f ~/.cargo/env ] && source ~/.cargo/env

        # smart case autocomplete
        zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'

        # tab to menu
        # bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
        # bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
        zstyle ':autocomplete:*complete*:*' insert-unambiguous yes
        export PATH="$PATH:/home/lukas/code/onecloud/bin"

        setopt HIST_EXPIRE_DUPS_FIRST
        setopt HIST_IGNORE_DUPS
        setopt HIST_IGNORE_ALL_DUPS
        setopt HIST_IGNORE_SPACE
        setopt HIST_FIND_NO_DUPS
        setopt HIST_SAVE_NO_DUPS
      '';

      plugins = [
        {
          name = "zsh-vi-mode";
          src = pkgs.fetchFromGitHub {
            owner = "jeffreytse";
            repo = "zsh-vi-mode";
            rev = "a3d717831c1864de8eabf20b946d66afc67e6695";
            sha256 = "peoyY+krpK/7dA3TW6PEpauDwZLe+riVWfwpFYnRn1Q=";
          };
        }
        {
          name = "powerlevel10k";
          file = "powerlevel10k.zsh-theme";
          src = pkgs.fetchFromGitHub {
            owner = "romkatv";
            repo = "powerlevel10k";
            rev = "862440ae112603c8e2d202f6edb94eeaa1509120";
            sha256 = "iJ35ZmlarMpwb5TOno273QrAaQJUmOBLDdGDowOo+qM=";
          };
        }
        {
          name = "powerline10kcfg";
          file = "p10k.zsh";
          src = ./plugins;
        }
        {
          name = "zsh-completions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-completions";
            rev = "86d55972f5cb65d545389fe0306e617b68328982";
            sha256 = "1c2xx9bkkvyy0c6aq9vv3fjw7snlm0m5bjygfk5391qgjpvchd29";
          };
        }
        {
          name = "nix-shell";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "af6f8a266ea1875b9a3e86e14796cadbe1cfbf08";
            sha256 = "BjgMhILEL/qdgfno4LR64LSB8n9pC9R+gG7IQWwgyfQ=";
          };
        }
        {
          name = "nix-zsh-completions";
          file = "nix-zsh-completions.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "nix-community";
            repo = "nix-zsh-completions";
            rev = "6a1bfc024481bdba568f2ced65e02f3a359a7692";
            sha256 = "aXetjkl5nPuYHHyuX59ywXF+4Xg+PUCV6Y2u+g18gEk=";
          };
        }
        {
          name = "zsh-autopairs";
          file = "zsh-autopair.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "hlissner";
            repo = "zsh-autopair";
            rev = "396c38a7468458ba29011f2ad4112e4fd35f78e6";
            sha256 = "PXHxPxFeoYXYMOC29YQKDdMnqTO0toyA7eJTSCV6PGE=";
          };
        }
        {
          name = "zsh-autocomplete";
          src = pkgs.fetchFromGitHub {
            owner = "marlonrichert";
            repo = "zsh-autocomplete";
            rev = "afc5afd15fe093bfd96faa521abe0255334c85b0";
            sha256 = "npflZ7sr2yTeLQZIpozgxShq3zbIB5WMIZwMv8rkLJg=";
          };
        }
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "c3d4e576c9c86eac62884bd47c01f6faed043fc5";
            sha256 = "2nKTlIG/2jmCNSgbXFlShBjs9c1NghWaPMMEssHzW84=";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "1e82d8c83efa8b9fd0c7d1b9baffeb47d6cff960";
            sha256 = "2nKTlIG/2jmCNSgbXFlShBjs9c1NghWaPMMEssHzW84=";
          };
        }
      ];
    };
  };
}
