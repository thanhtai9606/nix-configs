{ pkgs, ... }:

{
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

  environment.etc."hosts".mode = "0644";
}
