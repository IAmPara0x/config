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
      gnumake
      cmake
      (hiPrio clang-tools.override {
        llvmPackages = llvmPackages_16;
        enableLibcxx = false;
      })
      nil
      # Do not use the clangd from this package as it does not work correctly with
      # stdlib headers.
      llvmPackages_16.libstdcxxClang

      cudaPackages.cudnn
      cudatoolkit

      # Application launcher
      rofi

      # Media
      mpv
      pamixer

      # PDF(s) and readings
      zathura
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
  programs.bat.enable = true;
  systemd.user.startServices = "sd-switch";

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
