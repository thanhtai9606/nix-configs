{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    openconnect
    (neovim.override {
      withPython3 = true;
      extraPython3Packages = (p: with p; [ pynvim ]);
    })
    eza
    universal-ctags
    starship
    thunar
    k9s
    kubectl
    fzf
    ripgrep
    nodejs
    networkmanager-openconnect
    neovim
    wget
    git
    alacritty
    tmux
    ghostty
    gedit
    btop
    alacritty
    sway
    niri
    xwayland-satellite
    swaybg
    swaylock-effects
    swayidle
    fish
    wl-clipboard
    waybar
    mako
    fuzzel
    quickshell
    noctalia
    pixman
    wireplumber
    brightnessctl
    pavucontrol
    upower
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];
}
