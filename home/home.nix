{
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.zen-browser.homeModules.beta ];

  home.packages = [
    pkgs.claude-code
  ];

  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = "Ashtonaut";
          email = "jzqq6560@leeds.ac.uk";
        };
      };
    };

    zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      policies = {
        DontCheckDefaultBrowser = true;
      };
    };

    hyprlock = {
      enable = true;
      settings = {
        input-field = [ { monitor = ""; } ];
      };
    };

    kitty.enable = true;
    vim.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk4.theme = null;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
      ];
    };
  };

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
            mkBind = bindEntry: {
              _args = [
                "${mod} + ${bindEntry.key}"
                (lib.generators.mkLuaInline bindEntry.dsp)
              ];
            };

            wsKeys = builtins.genList (i: i + 1) 9;
            wsBindEntries =
              (map (n: {
                key = toString n;
                dsp = "hl.dsp.focus({ workspace = ${toString n} })";
              }) wsKeys)
              ++ (map (n: {
                key = "SHIFT + ${toString n}";
                dsp = "hl.dsp.window.move({ workspace = ${toString n}, follow = false })";
              }) wsKeys);

            bindEntries = [
              # Launch applications
              {
                key = "Return";
                dsp = ''hl.dsp.exec_cmd("kitty")'';
              }

              # Window management
              {
                key = "Q";
                dsp = "hl.dsp.window.close()";
              }
              {
                key = "SHIFT + Q";
                dsp = "hl.dsp.exit()";
              }
              {
                key = "L";
                dsp = ''hl.dsp.exec_cmd("loginctl lock-session")'';
              }

              # Move focus
              {
                key = "Left";
                dsp = ''hl.dsp.focus({ direction = "left" })'';
              }
              {
                key = "Right";
                dsp = ''hl.dsp.focus({ direction = "right" })'';
              }
              {
                key = "Up";
                dsp = ''hl.dsp.focus({ direction = "up" })'';
              }
              {
                key = "Down";
                dsp = ''hl.dsp.focus({ direction = "down" })'';
              }

              # Move windows
              {
                key = "SHIFT + Left";
                dsp = ''hl.dsp.window.move({ direction = "left" })'';
              }
              {
                key = "SHIFT + Right";
                dsp = ''hl.dsp.window.move({ direction = "right" })'';
              }
              {
                key = "SHIFT + Up";
                dsp = ''hl.dsp.window.move({ direction = "up" })'';
              }
              {
                key = "SHIFT + Down";
                dsp = ''hl.dsp.window.move({ direction = "down" })'';
              }
            ];
          in
          map mkBind (bindEntries ++ wsBindEntries);
      };
    };
  };

  home.stateVersion = "25.11";
}
