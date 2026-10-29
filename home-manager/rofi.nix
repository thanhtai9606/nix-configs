{ pkgs, config, ... }:

let
  # Wayland-capable since rofi-wayland was merged back into rofi.
  rofiPkg = pkgs.rofi;
  themeDir = ./rofi;
in
{
  programs.rofi = {
    enable = true;
    package = rofiPkg;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    font = "Noto Sans 20";
    location = "center";
    theme = "${themeDir}/gorgeHousse.rasi";
    cycle = true;
    extraConfig = {
      # Arch i3: rofi -lines 12 -padding 18 -width 60 -location 0 -sidebar-mode -columns 3
      modi = "drun,run,window,ssh,filebrowser";
      width = 60;
      lines = 12;
      padding = 18;
      "sidebar-mode" = true;
      columns = 3;
      "show-icons" = true;
      "icon-theme" = "Papirus-Dark";
      "drun-display-format" = "{name}";
      "disable-history" = false;
      sort = true;
      "sorting-method" = "fzf";
      "case-sensitive" = false;
      matching = "fuzzy";
      "scroll-method" = 0;
      "kb-row-up" = "Up,Control+k,Control+p";
      "kb-row-down" = "Down,Control+j,Control+n";
      "kb-accept-entry" = "Return,KP_Enter";
      "kb-remove-to-eol" = "Control+Shift+e";
      "kb-mode-next" = "Shift+Right,Control+Tab";
      "kb-mode-previous" = "Shift+Left,Control+ISO_Left_Tab";
      "display-drun" = " Apps";
      "display-run" = " Run";
      "display-window" = " Windows";
      "display-ssh" = " SSH";
      "display-filebrowser" = " Files";
    };
  };

  # Themes copied from my-arch-linux/files/rofi/
  xdg.configFile = {
    "rofi/gorgeHousse.rasi".source = "${themeDir}/gorgeHousse.rasi";
    "rofi/desert.rasi".source = "${themeDir}/desert.rasi";
    "rofi/Arc-Dark.rasi".source = "${themeDir}/Arc-Dark.rasi";
  };

  home.packages = with pkgs; [
    papirus-icon-theme
  ];

  home.shellAliases = {
    rofi-apps = "rofi -show drun";
    rofi-run = "rofi -show run";
    rofi-win = "rofi -show window";
    rofi-theme-desert = "rofi -show drun -theme desert";
    rofi-theme-arc = "rofi -show drun -theme Arc-Dark";
    rofi-theme-gorge = "rofi -show drun -theme gorgeHousse";
  };
}
