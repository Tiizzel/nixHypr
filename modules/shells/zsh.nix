{ ... }:

{
  flake.nixosModules.zsh = { pkgs, ... }: {
    programs.zsh.enable = true;
    environment.shellAliases = {
      sv = "sudo nvim";
      v = "nvim";
      c = "clear";
      fr = "nh os switch";
      fu = "nh os switch --update";
      fc = "nh clean all";
    };
    environment.systemPackages = [
      pkgs.oh-my-posh
    ];
  };

  flake.homeModules.zsh = { pkgs, ... }: {
    programs.zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
          "web-search"
          "copyfile"
          "copybuffer"
          "dirhistory"
        ];
      };
      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.zsh-autosuggestions;
          file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.zsh-syntax-highlighting;
          file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
        }
        {
          name = "fast-syntax-highlighting";
          src = pkgs.zsh-fast-syntax-highlighting;
          file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
        }
      ];
      initContent = ''
        # Load dotfiles zshrc fragments
        for f in ~/.config/zshrc/*; do
            [[ -d "$f" ]] && continue
            c="$(echo $f | sed -e 's=.config/zshrc=.config/zshrc/custom=')"
            [[ -f "$c" ]] && source "$c" || source "$f"
        done
      '';
    };
    programs.fzf.enable = true;
  };
}
