_:

{
  services.swaync = {
    enable = true;
    settings = {
      widgets = [
        "title"
        "dnd"
        "mpris"
        "notifications"
        "backlight"
        "volume"
      ];
      widget-config = {
        title = { };
        dnd = { };
        mpris = { };
        notifications = { };
        backlight = {
          device = "intel_backlight";
          subsystem = "backlight";
        };
        volume.label = "Volume";
      };
    };
  };

  systemd.user.services.swaync.Service = {
    RestartSec = "100ms";
    RestartSteps = 4;
    RestartMaxDelaySec = "5s";
  };
}
