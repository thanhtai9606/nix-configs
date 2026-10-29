{
  pkgs,
  ...
}:

let
  displayToggle = pkgs.writeShellScriptBin "nemo-display-toggle" ''
    set -euo pipefail
    STATE_FILE="''${XDG_RUNTIME_DIR:-/tmp}/nemo-display-mode"
    mode="$(cat "$STATE_FILE" 2>/dev/null || echo extend)"

    if [ "$mode" = "extend" ]; then
      kanshictl switch dual-mirror || true
      echo mirror > "$STATE_FILE"
      ${pkgs.libnotify}/bin/notify-send -a kanshi "Display" "Mirrored displays" || true
    else
      kanshictl switch dual-extend || true
      echo extend > "$STATE_FILE"
      ${pkgs.libnotify}/bin/notify-send -a kanshi "Display" "Extended dual-monitor" || true
    fi
  '';
in
{
  home.packages = with pkgs; [
    wdisplays
    kanshi
    jq
    libnotify
    displayToggle
  ];

  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";
    settings = [
      {
        profile.name = "single";
        profile.outputs = [
          {
            criteria = "HDMI-A-1";
            status = "enable";
            position = "0,0";
            scale = 1.0;
          }
        ];
      }
      {
        profile.name = "dual-extend";
        profile.outputs = [
          {
            criteria = "HDMI-A-1";
            status = "enable";
            position = "0,0";
            scale = 1.0;
          }
          {
            criteria = "DP-1";
            status = "enable";
            position = "1920,0";
            scale = 1.0;
          }
        ];
      }
      {
        profile.name = "dual-mirror";
        profile.outputs = [
          {
            criteria = "HDMI-A-1";
            status = "enable";
            mode = "1920x1080@60Hz";
            position = "0,0";
          }
          {
            criteria = "DP-1";
            status = "enable";
            mode = "1920x1080@60Hz";
            position = "0,0";
          }
        ];
      }
    ];
  };

  home.shellAliases = {
    displays = "wdisplays";
    display-toggle = "nemo-display-toggle";
    kanshi-mirror = "kanshictl switch dual-mirror";
    kanshi-extend = "kanshictl switch dual-extend";
  };
}
