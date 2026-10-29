{ pkgs, ... }:

{
  hardware.bluetooth.enable = true;

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.dbus.enable = true;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command =
        "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd ${pkgs.writeShellScriptBin "nemo-niri-session" ''
          export WLR_RENDERER=pixman
          export WLR_NO_HARDWARE_CURSORS=1
          exec ${pkgs.niri}/bin/niri-session
        ''}/bin/nemo-niri-session";
      user = "greeter";
    };
  };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  programs.dconf.enable = true;
  programs.nix-ld.enable = true;
  programs.firefox.enable = true;
  programs.niri.enable = true;
}
