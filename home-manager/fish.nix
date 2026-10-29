{ ... }:

{
  # Full config from ~/.config/fish (Arch/Garuda); HM must not overwrite config.fish.
  programs.fish.enable = false;

  xdg.configFile."fish/config.fish".source = ./fish/config.fish;
  xdg.configFile."fish/fish_variables".source = ./fish/fish_variables;
}
