{
  pkgs,
  ...
}:

let
  # Toggle mirror (presentation) ↔ extend (dual-monitor) via kanshictl
  displayToggle = pkgs.writeShellScriptBin "nemo-display-toggle" ''
    set -euo pipefail
    STATE_FILE="''${XDG_RUNTIME_DIR:-/tmp}/nemo-display-mode"
    mode="$(cat "$STATE_FILE" 2>/dev/null || echo extend)"

    if [ "$mode" = "extend" ]; then
      kanshictl switch projector-mirror || true
      echo mirror > "$STATE_FILE"
      ${pkgs.libnotify}/bin/notify-send -a kanshi "Display" "Projector mirror (presentation)" || true
    else
      kanshictl switch dual-monitor || true
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

  # Automatic display / projector profiles (user systemd via HM)
  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";
    settings = [
      # Laptop alone
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "1920x1080@60Hz";
            scale = 1.0;
            position = "0,0";
          }
        ];
      }

      # Extended workplace first so hotplug defaults to extend (not mirror).
      # Use Super+Alt+P / kanshictl to switch into projector-mirror for talks.
      {
        profile.name = "dual-monitor";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            position = "0,0";
            scale = 1.0;
          }
          {
            criteria = "HDMI-A-1";
            status = "enable";
            position = "1920,0";
            scale = 1.0;
          }
        ];
      }
      {
        profile.name = "dual-monitor-dp1";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            position = "0,0";
          }
          {
            criteria = "DP-1";
            status = "enable";
            position = "1920,0";
          }
        ];
      }
      {
        profile.name = "dual-monitor-dp2";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            position = "0,0";
          }
          {
            criteria = "DP-2";
            status = "enable";
            position = "1920,0";
          }
        ];
      }

      # Presentation: mirror @ 1080p (selected via nemo-display-toggle / kanshictl)
      {
        profile.name = "projector-mirror";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "1920x1080@60Hz";
            scale = 1.0;
            position = "0,0";
          }
          {
            criteria = "HDMI-A-1";
            status = "enable";
            mode = "1920x1080@60Hz";
            scale = 1.0;
            position = "0,0"; # same origin → mirror
          }
        ];
      }
      {
        profile.name = "projector-mirror-dp1";
        profile.outputs = [
          {
            criteria = "eDP-1";
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
      {
        profile.name = "projector-mirror-dp2";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "1920x1080@60Hz";
            position = "0,0";
          }
          {
            criteria = "DP-2";
            status = "enable";
            mode = "1920x1080@60Hz";
            position = "0,0";
          }
        ];
      }
    ];
  };

  # Keybinds for displays live in niri.nix:
  # Super+Shift+P → wdisplays, Super+Alt+P → nemo-display-toggle

  home.shellAliases = {
    displays = "wdisplays";
    display-toggle = "nemo-display-toggle";
    kanshi-mirror = "kanshictl switch projector-mirror";
    kanshi-extend = "kanshictl switch dual-monitor";
  };
}
