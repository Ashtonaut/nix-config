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
          mkBind = key: expr: {
            _args = [
              key
              (lib.generators.mkLuaInline expr)
            ];
          };
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

          binds = {
            # Launch applications
            "${mod} + Return" = ''hl.dsp.exec_cmd("kitty")'';
            "${mod} + D" = ''hl.dsp.exec_cmd("rofi -show drun")'';

            # Window management
            "${mod} + Q" = "hl.dsp.window.close()";
            "${mod} + SHIFT + Q" = "hl.dsp.exit()";
            "${mod} + L" = ''hl.dsp.exec_cmd("loginctl lock-session")'';
          };
        in
        lib.mapAttrsToList mkBind binds ++ dirBinds ++ wsBinds;
    };
  };
}
