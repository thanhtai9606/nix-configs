# Terminal fonts here; MS/WPS fonts are system-wide in nixos/packages.nix (fonts.packages).
{pkgs, ...}: {
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        "Fira Code"
        "FiraCode Nerd Font"
        "JetBrainsMono Nerd Font"
        "Consolas"
      ];
      sansSerif = [
        "Noto Sans"
        "Calibri"
        "Arial"
        "Liberation Sans"
      ];
      serif = [
        "Noto Serif"
        "Cambria"
        "Times New Roman"
        "Liberation Serif"
      ];
    };
  };

  home.packages = with pkgs; [
    fira-code
  ];

  # Ghostty is on the system PATH but has no HM module here — font via config.
  xdg.configFile."ghostty/config".text = ''
    font-family = Fira Code
    font-size = 12
    font-feature = calt
    font-feature = liga
  '';
}
