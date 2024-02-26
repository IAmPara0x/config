{ config, ... }: {

  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" "zsh-vi-mode" "zsh-autosuggestions" ];
      theme = "robbyrussell";
    };
    history.size = 50000;
    initExtra = ''
      ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
    '';
    enableCompletion = true;
  };

  shellAliases = {
    rebuild =
      "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/nixos#default";
  };
}
