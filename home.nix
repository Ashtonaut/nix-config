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
    };
  }; 

  home.stateVersion = "25.11";
}
