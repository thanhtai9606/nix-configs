# Shared system configuration for all hosts (user nemo). Hardware is per-machine.
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./boot.nix
    ./networking.nix
    ./desktop.nix
    ./locale.nix
    ./packages.nix
    ./dev.nix
    ./users.nix
    ./home-manager.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    # .NET 7 is EOL in nixpkgs but still needed for older projects.
    permittedInsecurePackages = [
      "dotnet-sdk-7.0.410"
      "dotnet-runtime-7.0.20"
    ];
  };

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
