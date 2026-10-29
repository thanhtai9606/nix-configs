{ pkgs, ... }:

{
  programs.fish.enable = true;

  users.users.nemo = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];
    packages = with pkgs; [
      tree
    ];
  };
}
