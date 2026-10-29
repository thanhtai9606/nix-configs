{ pkgs, ... }:

let
  # Not in nixpkgs; https://github.com/dhamidi/tmenu
  tmenu = pkgs.stdenv.mkDerivation (finalAttrs: {
    pname = "tmenu";
    version = "0.1.1";
    src = pkgs.fetchFromGitHub {
      owner = "dhamidi";
      repo = "tmenu";
      rev = "v${finalAttrs.version}";
      hash = "sha256-MwA0+Ysdf4ZCwk5bY9CDYf3+ne6Xz+mzxRjVvan+6ZA=";
    };
    # Upstream Makefile breaks under GNU make (empty explicit *.o targets).
    buildPhase = ''
      runHook preBuild
      for src in main terminal util textbuffer buffer menu; do
        script/compile "''${src}.c" "''${src}.o"
      done
      script/link tmenu main.o terminal.o textbuffer.o buffer.o menu.o util.o
      runHook postBuild
    '';
    installPhase = ''
      runHook preInstall
      install -Dm755 tmenu $out/bin/tmenu
      install -Dm644 tmenu.1 $out/share/man/man1/tmenu.1
      runHook postInstall
    '';
    meta = with pkgs.lib; {
      description = "Dynamic fuzzy menu for tty devices";
      homepage = "https://github.com/dhamidi/tmenu";
      license = licenses.gpl3Only;
      platforms = platforms.linux;
      mainProgram = "tmenu";
    };
  });
in
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
    tmenu

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
