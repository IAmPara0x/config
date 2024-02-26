{ pkgs,  ... }:

let

  theme = "mocha";
  catppuccin-kitty-theme = pkgs.callPackage ./catppuccin-kitty.nix {inherit theme;};
in {

  programs.kitty = {
    enable = true;
    font.size = 10;
    font.name = "JetBrainsMonoNL NFM SemiBold";
    extraConfig = ''
      include ${catppuccin-kitty-theme}/${theme}.conf
      font_family      JetBrainsMonoNL NFM SemiBold
      bold_font        auto
      italic_font      auto
      bold_italic_font auto
    '';
  };
}

