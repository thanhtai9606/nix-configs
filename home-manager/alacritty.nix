{ pkgs, ... }:

{
  # Alacritty ≥0.13 uses TOML; settings below match home-manager/alacritty.yml (my-arch-linux).
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    fira-code
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 12.0;
        normal = {
          family = "Fira Code";
          style = "Regular";
        };
        bold = {
          family = "Fira Code";
          style = "Bold";
        };
        italic = {
          family = "Fira Code";
          style = "Italic";
        };
        bold_italic = {
          family = "Fira Code";
          style = "Bold Italic";
        };
      };
    };
  };

  home.sessionVariables = {
    TERMINAL = "alacritty";
  };
}
