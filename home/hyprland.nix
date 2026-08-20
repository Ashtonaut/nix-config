{
  lib,
  ...
}:

{
  wayland.windowManager.hyprland = {
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

      config.input.kb_layout = "gb";

      bind =
        let
          mod = "SUPER";
          mkFlagBind = flags: key: expr: {
            _args = [
              key
              (lib.generators.mkLuaInline expr)
            ]
            ++ lib.optional (flags != { }) flags;
          };
          mkBind = mkFlagBind { };
          mkFocusMove =
            {
              key,
              focus,
              move ? focus,
            }:
            [
              (mkBind "${mod} + ${key}" "hl.dsp.focus({ ${focus} })")
              (mkBind "${mod} + SHIFT + ${key}" "hl.dsp.window.move({ ${move} })")
            ];

          dirs = {
            Left = "left";
            Right = "right";
            Up = "up";
            Down = "down";
          };
          dirBinds = lib.concatLists (
            lib.mapAttrsToList (
              key: dir:
              mkFocusMove {
                inherit key;
                focus = ''direction = "${dir}"'';
              }
            ) dirs
          );

          wsNums = map toString (lib.range 1 9);
          wsBinds = lib.concatMap (
            n:
            mkFocusMove {
              key = n;
              focus = "workspace = ${n}";
              move = "workspace = ${n}, follow = false";
            }
          ) wsNums;

          fnBinds = [
            (mkFlagBind {
              locked = true;
            } "XF86AudioMute" ''hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle")'')
            (mkFlagBind {
              locked = true;
              repeating = true;
            } "XF86AudioLowerVolume" ''hl.dsp.exec_cmd("swayosd-client --output-volume lower")'')
            (mkFlagBind {
              locked = true;
              repeating = true;
            } "XF86AudioRaiseVolume" ''hl.dsp.exec_cmd("swayosd-client --output-volume raise")'')
            (mkFlagBind {
              locked = true;
              repeating = true;
            } "XF86MonBrightnessDown" ''hl.dsp.exec_cmd("swayosd-client --brightness lower")'')
            (mkFlagBind {
              locked = true;
              repeating = true;
            } "XF86MonBrightnessUp" ''hl.dsp.exec_cmd("swayosd-client --brightness raise")'')
          ];

          binds = {
            # Launch applications
            "${mod} + Return" = ''hl.dsp.exec_cmd("kitty")'';
            "${mod} + D" = ''hl.dsp.exec_cmd("rofi -show drun")'';

            # Window management
            "${mod} + Q" = "hl.dsp.window.close()";
            "${mod} + SHIFT + Q" = "hl.dsp.exit()";
            "${mod} + L" = ''hl.dsp.exec_cmd("loginctl lock-session")'';

            # Screenshots
            # Fn + F11 registers as BOTH:
            #   SUPER + SHIFT + XF86SelectiveScreenshot
            #   SUPER + SHIFT + S
            "SUPER + SHIFT + XF86SelectiveScreenshot" = ''hl.dsp.exec_cmd("screenshot region")'';
            "SUPER + SHIFT + S" = "hl.dsp.no_op()";
            "Print" = ''hl.dsp.exec_cmd("screenshot full")'';
          };
        in
        lib.mapAttrsToList mkBind binds ++ dirBinds ++ wsBinds ++ fnBinds;
    };
  };
}
