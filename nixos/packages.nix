{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # CLI / dev
    vim
    git
    wget
    eza
    fzf
    ripgrep
    universal-ctags
    starship
    nodejs
    kubectl
    k9s

    # VPN (fish alias vpn-becamex uses openconnect)
    openconnect
    networkmanager-openconnect

    # Desktop session (niri + noctalia; details in home-manager/)
    niri
    noctalia
    fuzzel
    xwayland-satellite
    pixman
    alacritty
    tmux
    fish
    wl-clipboard
    btop
    thunar
    firefox

    # Audio / power / display helpers
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
