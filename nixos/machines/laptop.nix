{
  imports = [
    ../configuration.nix
    ../hardware/laptop.nix
  ];

  networking.hostName = "nemo-laptop";
}
