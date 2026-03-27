{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" "catppuccin" "neon-comfy-soft-themes" ];

    userSettings = {
      theme = {
        mode = "system";
        light = "One Light";
        dark = "Hellwal Dynamic";
      };

      "window.background_appearance" = "transparent";

      "theme_overrides" = {
        "Hellwal Dynamic" = {
          "syntax" = {
            "comment" = { "font_style" = "italic"; };
          };
          "background" = "#00000000";
          "editor.background" = "#00000000";
          "status_bar.background" = "#00000000";
          "title_bar.background" = "#00000000";
          "toolbar.background" = "#00000000";
          "tab_bar.background" = "#00000000";
        };
      };

      lsp = {
        nixd = {
          binary = {
            path = "nixd";
          };
        };
      };

      languages = {
        Nix = {
          language_servers = [ "nixd" ];
          format_on_save = "on";
        };
      };
    };
  };

  home.packages = [ pkgs.nixd pkgs.nixpkgs-fmt ];

}
