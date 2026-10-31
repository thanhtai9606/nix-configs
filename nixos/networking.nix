{ pkgs, ... }:

{
  # networking.nameservers = [
  #   "1.1.1.1"
  #   "8.8.8.8"
  # ];

  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
    plugins = with pkgs; [
      networkmanager-openconnect
      networkmanager-openvpn
    ];
  };

  services.resolved.enable =  true;
  programs.nm-applet.enable = true;
}
