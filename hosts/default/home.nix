{ config, pkgs, ... }:

let
  homeDirectory = config.home.homeDirectory;
  polybar-fonts = pkgs.callPackage ../../modules/polybar-fonts.nix { };

in {

  imports = [
    ./modules/nodejs.nix
    ./modules/python.nix
    ./modules/lua.nix
    ./modules/zsh.nix
    ./modules/kitty.nix
    ./modules/cli.nix
    ./modules/xdg.nix
    ../../modules/firefox.nix
  ];

  home = {

    username = "paradox";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "23.11"; # Please read the comment before changing.

    packages = with pkgs; [

      # COMPILERS:
      gcc
      rustc
      cargo
      ruby


      # Application launcher
      rofi

      # Media
      mpv


      # PDF(s) and readings
      zathura
      zotero
      okular


      # browser
      ungoogled-chromium

      # notifications
      dunst

      # Fonts
      polybar-fonts
      (nerdfonts.override {
        fonts = [ "FiraCode" "Mononoki" "JetBrainsMono" ];
      })

      # Misc

      nixfmt
      tree-sitter
      direnv
    ];

    file = {

      "${homeDirectory}/.tmux.conf".source = ./config/tmux/.tmux.conf;

      "${homeDirectory}/.config/Wallpapers" = {
        recursive = true;
        source = ./config/Wallpapers;
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

      "${homeDirectory}/.config/rofi" = {
        recursive = true;
        source = ./config/rofi;
      };

      "${homeDirectory}/.emacs.d" = {
        recursive = true;
        source = ./config/emacs;
      };

    };

    # Let Home Manager install and manage itself.
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.neovim.enable = true;
  programs.emacs.enable = true;
  programs.bat.enable = true;
  systemd.user.startServices = "sd-switch";

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Macchiato-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        tweaks = [ "rimless" "black" ];
        variant = "macchiato";
      };
    };
  };

  fonts.fontconfig.enable = true;
}
