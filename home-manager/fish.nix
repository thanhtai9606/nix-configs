{ ... }:

{
  # Managed fish config; HM must not overwrite config.fish via programs.fish.
  programs.fish.enable = false;

  xdg.configFile."fish/config.fish".source = ./fish/config.fish;
  xdg.configFile."fish/fish_variables".source = ./fish/fish_variables;
}
