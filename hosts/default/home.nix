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
    ./modules/vim.nix
    ./modules/kitty.nix
    ./modules/cli.nix
    ./modules/xdg.nix
    ./modules/sioyek.nix
    ../../modules/firefox.nix
    ./modules/chromium.nix
  ];

  home = {

    username = "paradox";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "23.11"; # Please read the comment before changing.

    packages = with pkgs; [

      # COMPILERS:
      rustc
      cargo
      ruby

      # man pages

      man-pages
      man-pages-posix

      # Nix language server
      nil

      # Application launcher
      rofi

      # Media
      mpv
      mpd
      pamixer
      mpc-cli

      # PDF(s) and readings
      zotero
      okular

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
      tomato-c
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
  programs.neovim.enable = true;
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: with epkgs; [ tree-sitter-langs tree-sitter ];
  };

  programs.ncmpcpp = {
    enable = true;
    settings = {
      mpd_host = "/run/user/1000/mpd/socket";
    };
  };

  programs.bat.enable = true;
  systemd.user.startServices = "sd-switch";



  services.mpd = {
    enable = true;
    musicDirectory = "/home/paradox/Music/";
    extraConfig = 
    ''
      audio_output {
        type "pipewire"
        name "My Pipewire output"
      }
    '';

    # Optional:
    network.listenAddress = "any"; # if you want to allow non-localhost connections
    network.startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Macchiato-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "macchiato";
      };
    };
  };

  fonts.fontconfig.enable = true;
}
