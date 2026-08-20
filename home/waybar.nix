_:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.mainBar = {
      layer = "top";
      position = "top";

      modules-left = [
        "hyprland/workspaces"
        "hyprland/window"
      ];
      modules-center = [ "clock" ];
      modules-right = [
        "wireplumber"
        "backlight"
        "battery"
        "network"
        "tray"
      ];

      clock.format = "{:%a %F %H:%M}";
      battery.format = "BAT {capacity}%";
      wireplumber.format = "VOL {volume}%";
      backlight.format = "BRI {percent}%";
      network = {
        format-wifi = "{essid} ({signalStrength}%)";
        format-ethernet = "eth";
        format-disconnected = "offline";
      };
    };
  };
}
