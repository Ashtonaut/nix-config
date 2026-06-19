{ config, lib, pkgs, ... }:

{
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
    kitty.enable = true;
    vim.enable = true;
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
              _args = [ "${mod} + ${bindEntry.key}" (lib.generators.mkLuaInline bindEntry.dispatcher) ];
            };
            bindEntries = [
              { key = "Return"; dispatcher = ''hl.dsp.exec_cmd("kitty")''; }
              { key = "Q"; dispatcher = ''hl.dsp.window.close()''; }
              { key = "SHIFT + Q"; dispatcher = ''hl.dsp.exit()''; }
            ];
          in
          map mkBind bindEntries;
      };
    };
  }; 

  home.stateVersion = "25.11";
}
