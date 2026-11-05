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
    192.168.103.193 dashboard.becamex.com.vn
    192.168.103.9 luutru-app-uat.becamex.com.vn administration-dev.becamex.com.vn authserver-dev.becamex.com.vn xlnt.becamex.com.vn
  '';
}
