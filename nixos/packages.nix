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
    lazydocker
    fastfetch
    bat
    qutebrowser

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
    ghostty
    tmux
    fish
    wl-clipboard
    btop
    thunar
    firefox
    wpsoffice

    # Audio / power / display helpers
    wireplumber
    brightnessctl
    pavucontrol
    upower

    # Dev / containers / databases
    vscode
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
    fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code

    # Microsoft / Office-style (unfree; nixpkgs.config.allowUnfree = true)
    corefonts # Arial, Times New Roman, Verdana, Courier New, …
    vista-fonts # Calibri, Cambria, Consolas, Corbel, Candara, …
    vista-fonts-chs # 宋体/黑体/… — file .doc/.xlsx tiếng Trung trong WPS
    vista-fonts-cht # 正黑體/… — bản Traditional (tùy chọn, giữ cho đủ bộ WPS)
    liberation_ttf # fallback metric-compatible khi thiếu font MS
  ];
}
