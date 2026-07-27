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
            } "XF86AudioMute" ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")'')
            (mkFlagBind {
              locked = true;
              repeating = true;
            } "XF86AudioLowerVolume" ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")'')
            (mkFlagBind {
              locked = true;
              repeating = true;
            } "XF86AudioRaiseVolume" ''hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+")'')
            (mkFlagBind {
              locked = true;
              repeating = true;
            } "XF86MonBrightnessDown" ''hl.dsp.exec_cmd("brightnessctl set 5%-")'')
            (mkFlagBind {
              locked = true;
              repeating = true;
            } "XF86MonBrightnessUp" ''hl.dsp.exec_cmd("brightnessctl set 5%+")'')
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
            "${mod} + SHIFT + XF86SelectiveScreenshot" = ''hl.dsp.exec_cmd("screenshot region")'';
            "Print" = ''hl.dsp.exec_cmd("screenshot full")'';
          };
        in
        lib.mapAttrsToList mkBind binds ++ dirBinds ++ wsBinds ++ fnBinds;
    };
  };
}
