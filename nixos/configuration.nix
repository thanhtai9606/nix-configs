# System configuration (flake module). Mirrors /etc/nixos on host nemo.
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./networking.nix
    ./desktop.nix
    ./locale.nix
    ./packages.nix
    ./users.nix
    ./home-manager.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      flake-registry = "";
    };
    channel.enable = false;
  };

  system.stateVersion = "26.05";
}
