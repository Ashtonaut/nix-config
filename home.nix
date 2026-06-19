{ config, lib, pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      userName = "Ashtonaut";
      userEmail = "jzqq6560@leeds.ac.uk";
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
            mkBind = key: dispatcher: {
              _args = [ "${mod} + ${key}" (lib.generators.mkLuaInline dispatcher) ];
            };
          in
          [
            (mkBind "Q" ''hl.dsp.exec_cmd("kitty")'')
            (mkBind "C" "hl.dsp.window.close()")
            (mkBind "M" "hl.dsp.exit()")
          ];
      };
    };
  }; 

  home.stateVersion = "25.11";
}
