{ pkgs, ... }:

{
  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openconnect
      networkmanager-openvpn
    ];
  };

  programs.nm-applet.enable = true;
}
