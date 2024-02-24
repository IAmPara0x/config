{ config, pkgs, ... }:

let 
  homeDirectory = config.home.homeDirectory;
in

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "paradox";
  home.homeDirectory = "/home/${config.home.username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; 
    [ neovim
      gcc
      feh
      lua
      fzf
      ripgrep
      unzip
      cargo
      rustc
      nodejs_21
      nodePackages.pyright
      fd
      ruby
      luajitPackages.luarocks
      tree-sitter
      starship
      zoxide
      thefuck
      direnv
    ];

  home.shellAliases = {
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {

    # TODO: copy tmux conf in config
    "${homeDirectory}/.tmux.conf".source = ./config/tmux/.tmux.conf;

    "${homeDirectory}/.config/Wallpapers" = {
      recursive = true;
      source = ./config/Wallpapers;
    };

    "${homeDirectory}/.config/kitty" = {
      recursive = true;
      source = ./config/kitty;
    };

    "${homeDirectory}/.config/bspwm" = {
      recursive = true;
      source = ./config/bspwm;
    };

    "${homeDirectory}/.config/sxhkd" = {
      recursive = true;
      source = ./config/sxhkd;
    };

    "${homeDirectory}/.config/polybar" = {
      recursive = true;
      source = ./config/polybar;
    };

    "${homeDirectory}/.config/nvim" = {
      recursive = true;
      source = ./config/nvim;
    };

    "${homeDirectory}/.config/fish" = {
      recursive = true;
      source = ./config/fish;
    };

  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/paradox/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.fish = {
    enable = true;
    shellAliases = {  rebuild = "sudo nixos-rebuild switch --flake /home/paradox/nixos#default"; vim = "nvim"; };

  };

  gtk = {
    enable = true;
  };

  programs.emacs.enable = true;

  # Let Home Manager install and manage itself.
}
