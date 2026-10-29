{
  inputs,
  ...
}:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-backup";
    extraSpecialArgs = {inherit inputs;};
    users.nemo = import ../home-manager;
  };
  programs.nix-ld.enable = true;
  programs.firefox.enable = true;
  programs.niri.enable = true;

}
