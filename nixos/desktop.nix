{ pkgs, ... }:

{
  hardware.bluetooth.enable = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.dbus.enable = true;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri";
      user = "greeter";
    };
  };

  programs.nix-ld.enable = true;
  programs.firefox.enable = true;
  programs.niri.enable = true;
}
