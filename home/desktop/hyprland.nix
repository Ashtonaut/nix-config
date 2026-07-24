{
  lib,
  ...
}:

{
  wayland.windowManager = {
    hyprland = {
      enable = true;
      configType = "lua";
      package = null;
      portalPackage = null;

      settings = {
        monitor = [
          {
            output = "eDP-1";
            mode = "1920x1080@60";
            position = "0x0";
            scale = 1;
          }
        ];

        config = {
          input = {
            kb_layout = "gb";
          };
        };

        bind =
          let
            mod = "SUPER";
            mkBind = key: dsp: {
              _args = [
                key
                (lib.generators.mkLuaInline dsp)
              ];
            };

            wsNums = lib.range 1 9;
            wsBinds = lib.concatMap (n: [
              (mkBind "${mod} + ${toString n}" "hl.dsp.focus({ workspace = ${toString n} })")
              (mkBind "${mod} + SHIFT + ${toString n}" "hl.dsp.window.move({ workspace = ${toString n}, follow = false })")
            ]) wsNums;

            binds = {
              # Launch applications
              "${mod} + Return" = ''hl.dsp.exec_cmd("kitty")'';
              "${mod} + D" = ''hl.dsp.exec_cmd("rofi -show drun")'';

              # Window management
              "${mod} + Q" = "hl.dsp.window.close()";
              "${mod} + SHIFT + Q" = "hl.dsp.exit()";
              "${mod} + L" = ''hl.dsp.exec_cmd("loginctl lock-session")'';

              # Move focus
              "${mod} + Left" = ''hl.dsp.focus({ direction = "left" })'';
              "${mod} + Right" = ''hl.dsp.focus({ direction = "right" })'';
              "${mod} + Up" = ''hl.dsp.focus({ direction = "up" })'';
              "${mod} + Down" = ''hl.dsp.focus({ direction = "down" })'';

              # Move windows
              "${mod} + SHIFT + Left" = ''hl.dsp.window.move({ direction = "left" })'';
              "${mod} + SHIFT + Right" = ''hl.dsp.window.move({ direction = "right" })'';
              "${mod} + SHIFT + Up" = ''hl.dsp.window.move({ direction = "up" })'';
              "${mod} + SHIFT + Down" = ''hl.dsp.window.move({ direction = "down" })'';
            };
          in
          lib.mapAttrsToList mkBind binds ++ wsBinds;
      };
    };
  };
}
