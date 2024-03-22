{ pkgs, lib, ... }: {

  programs.sioyek = {
    enable = true;
    config = {
      "background_color" = "#1e1e2e";
      "text_highlight_color" = "#f9e2af";
      "visual_mark_color" = "#7f849c";
      "search_highlight_color" = "#f9e2af";
      "link_highlight_color" = "#89b4fa";
      "synctex_highlight_color" = "#a6e3a1";
      "highlight_color_a" = "#f9e2af";
      "highlight_color_b" = "#a6e3a1";
      "highlight_color_c" = "#89dceb";
      "highlight_color_d" = "#eba0ac";
      "highlight_color_e" = "#cba6f7";
      "highlight_color_f" = "#f38ba8";
      "highlight_color_g" = "#f9e2af";
      "custom_background_color" = "#1e1e2e";
      "custom_text_color" = "#cdd6f4";
      "ui_text_color" = "#cdd6f4";
      "ui_background_color" = "#313244";
      "ui_selected_text_color" = "#cdd6f4";
      "ui_selected_background_color" = "#585b70";
    };
  };
}
