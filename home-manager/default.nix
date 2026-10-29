{
  pkgs,
  ...
}:

{
  imports = [
    ./alacritty.nix
    ./tmux.nix
    ./neovim.nix
  ];

  home = {
    username = "nemo";
    homeDirectory = "/home/nemo";
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;
}
