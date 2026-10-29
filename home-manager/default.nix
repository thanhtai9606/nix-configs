{
  pkgs,
  hostProfile ? "laptop",
  lib,
  ...
}:

{
  imports =
    [
      ./alacritty.nix
      ./fish.nix
      ./niri.nix
      ./tmux.nix
      ./neovim.nix
    ]
    ++ lib.optionals (hostProfile == "laptop") [
      ./display-kanshi.nix
    ]
    ++ lib.optionals (hostProfile == "desktop") [
      ./display-kanshi-desktop.nix
    ];

  xdg.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
  };

  home = {
    username = "nemo";
    homeDirectory = "/home/nemo";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;
}
