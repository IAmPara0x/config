{ config, pkgs, ... }: {


  home.packages = with pkgs; [ starship thefuck zsh-vi-mode ];

  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;

  programs.zsh = {
    enable = true;

    autocd = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    history.size = 50000;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" "vi-mode" ];
      theme = "robbyrussell";
    };

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/nixos#default";
      cleanup = "sudo nix-collect-garbage -d";
      l = "eza -lF --time-style=long-iso --icons";
      la = "eza -lah --tree";
      ls = "eza -h --git --icons --color=auto --group-directories-first -s extension";
      cat = "bat --theme=base16 --number --color=always --paging=never --tabs=2 --wrap=never";
    };

    initExtra = ''
      bindkey -M viins 'jk' vi-cmd-mode
    '';

    sessionVariables = { EDITOR = "nvim"; };

  };

}
