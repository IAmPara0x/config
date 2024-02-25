{ config, pkgs, ... }:

let 
  homeDirectory = config.home.homeDirectory;
  gillsans = pkgs.callPackage ../../modules/polybar-fonts.nix { };
in

{


  imports = 
    [ ./modules/nodejs.nix
      ./modules/python.nix
      ./modules/lua.nix
      # ../../modules/firefox.nix
    ];


  home = {

  username = "paradox";
  homeDirectory = "/home/${config.home.username}";
  stateVersion = "23.11"; # Please read the comment before changing.


  packages = with pkgs; 
    [ neovim
      gcc
      feh
      fzf
      ripgrep
      unzip
      cargo
      rustc
      fd
      ruby
      tree-sitter
      starship
      zoxide
      thefuck
      direnv
      nixfmt
      okular
      rofi
      ungoogled-chromium
      zathura
      zotero

      (nerdfonts.override { fonts = [ "FiraCode" "Mononoki" "JetBrainsMono" ]; })

      # MISC packages
      tree
      btop
      gillsans
    ];

  file = {

    "${homeDirectory}/.tmux.conf".source = ./config/tmux/.tmux.conf;
    # "${homeDirectory}/.config/picom.conf".source = ./config/picom/picom.conf;

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

    "${homeDirectory}/.config/rofi" = {
      recursive = true;
      source = ./config/rofi;
    };

    "${homeDirectory}/.emacs.d" = {
      recursive = true;
      source = ./config/emacs;
    };

  };

  sessionVariables = {
    EDITOR = "nvim";
  };


  # Let Home Manager install and manage itself.
};

  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.fish.enable = true;
  programs.emacs.enable = true;
  systemd.user.startServices = "sd-switch";

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

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };


fonts.fontconfig.enable = true;

}
