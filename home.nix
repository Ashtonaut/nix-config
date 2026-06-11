{ config, lib, pkgs, ... }:

{
  programs = {
    git.enable = true;
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
