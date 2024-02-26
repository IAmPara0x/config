{ config, pkgs, ... }: {

  home.packages = with pkgs; [ starship thefuck zsh-vi-mode ];

  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;

  programs.zsh = {
    enable = true;
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
      rebuild =
        "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/nixos#default";
    };

    initExtra = ''
      bindkey -M viins 'jk' vi-cmd-mode
    '';

    sessionVariables = { EDITOR = "nvim"; };

  };

}
