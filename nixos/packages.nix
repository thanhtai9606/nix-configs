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
    kubectl
    k9s
    lazygit

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

    # Dev / containers / databases
    docker
    docker-compose
    dbeaver-bin
    go
    nodejs
    pnpm
    dotnet-sdk_10
    dotnet-runtime_8
    dotnet-runtime_9
    dotnet-runtime_10
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];
}
