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

  networking.extraHosts = ''
    192.168.103.182 workhub-dev.becamex.com.vn
    192.168.103.193 ceph-ai.becamex.com.vn
  '';
}
