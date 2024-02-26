{ pkgs, ... }:
let

  theme = "mocha";
  catppuccin-zathura-theme =
    pkgs.callPackage ../../../modules/catppuccin-zathura.nix { inherit theme; };
in {

  programs.zathura = {
    enable = true;
    extraConfig = ''
      include ${catppuccin-zathura-theme}/catppuccin-${theme}.conf
      font_family      JetBrainsMonoNL NFM SemiBold
      bold_font        auto
      italic_font      auto
      bold_italic_font auto
    '';
  };
}

