{ ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 10000;
    terminal = "tmux-256color";
    mouse = true;

    extraConfig = builtins.readFile ./tmux.conf;
  };
}
