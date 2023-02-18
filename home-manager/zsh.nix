{ inputs, lib, config, pkgs, ... }: { # zsh config
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    defaultKeymap = "viins";
    dotDir = ".config/zsh";
    history = {
      expireDuplicatesFirst = true;
      save = 100000000;
      size = 1000000000;
    };

    shellAliases = {
      vi = "\${EDITOR:-nvim}";
      vim = "\${EDITOR:-nvim}";
      emacs = "man nvim";

      ls = "exa -al --color=always --group-directories-first";
      entar = "tar -acf ";
      untar = "tar -zxvf ";
      wget = "wget -c ";
      grep = "grep --color=auto";
      cat = "bat";

      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      "......" = "cd ../../../../..";

      apt = "man nix-env";
      apt-get = "man nix-env";
    };


    oh-my-zsh = {
      enable = true;

      plugins = [
        "command-not-found"
        "git"
        "sudo"
      ];
    };

    plugins = [
      {
        name = "powerlevel10k";
        file = "powerlevel10k.zsh-theme";
        src = pkgs.fetchFromGitHub {
          owner = "romkatv";
          repo = "powerlevel10k";
          rev = "a30145b0f82d06770e924e9eac064ed223a94e6b";
          sha256 = "jnZXLrywUrJgTX1tFpoNH94r/jcGl2P6R7DoedluHxQ=";
        };
      }
      {
        name = "powerline10kcfg";
        file = "p10k.zsh";
        src = ./zsh;
      }
      {
        name = "zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "86d55972f5cb65d545389fe0306e617b68328982";
          sha256 = "1c2xx9bkkvyy0c6aq9vv3fjw7snlm0m5bjygfk5391qgjpvchd29";
        };
      } /*
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "754cefe0181a7acd42fdcb357a67d0217291ac47";
          sha256 = "kWgPe7QJljERzcv4bYbHteNJIxCehaTu4xU9r64gUM4=";
        };
      } */
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
        name = "nix-completions";
        src = pkgs.fetchFromGitHub {
          owner = "nix-community";
          repo = "nix-zsh-completions";
          rev = "6a1bfc024481bdba568f2ced65e02f3a359a7692";
          sha256 = "aXetjkl5nPuYHHyuX59ywXF+4Xg+PUCV6Y2u+g18gEk=";
        };
      }
      {
        name = "zah-autopairs";
        src = pkgs.fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "396c38a7468458ba29011f2ad4112e4fd35f78e6";
          sha256 = "PXHxPxFeoYXYMOC29YQKDdMnqTO0toyA7eJTSCV6PGE=";
        };
      }
    ];
  };
}