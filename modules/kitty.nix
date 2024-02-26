{ config, pkgs, lib }:
let

  theme = "mocha";
  catppuccin-kitty-theme = pkgs.stdenvNoCC {
    name = "catppuccin-kitty-theme";
    dontConfigure = true;

    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "kitty";
      rev = "d7d61716a83cd135344cbb353af9d197c5d7cec1";
      sha256 = "sha256-n5UcGHU/DQYezIma9w3zAQ2QZ7q6TmnbWYghT0EIETU=";
    };
    installPhase = 
    ''
      mkdir $out
      cp ./themes/${theme}.conf $out
    '';
  };
in {

  programs.kitty = {
    enable = true;
    font.size = 10;
    extraConfig = ''
      include ${catppuccin-kitty-theme}/${theme}.conf
      font_family      JetBrainsMonoNL NFM SemiBold
      bold_font        auto
      italic_font      auto
      bold_italic_font auto
    '';
  };
}

