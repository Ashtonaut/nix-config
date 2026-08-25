_:

{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    package = null;
    portalPackage = null;

    extraLuaFiles."config.lua" = ./config.lua;
  };
}
