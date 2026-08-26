{
  pkgs,
  osConfig,
  ...
}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = false;
    withRuby = false;

    plugins = [
      pkgs.vimPlugins.render-markdown-nvim
      pkgs.vimPlugins.nvim-lspconfig
    ];
    extraPackages = [ pkgs.lua-language-server ];
  };

  xdg.configFile = {
    "nvim/ftplugin/markdown.lua".source = ./ftplugin/markdown.lua;
    "nvim/plugin/options.lua".source = ./plugin/options.lua;
    "nvim/plugin/lsp.lua".source = ./plugin/lsp.lua;

    "nvim/lua/nixpaths.lua".text =
      ''return { hlStubs = "${osConfig.programs.hyprland.package}/share/hypr/stubs" }'';
  };
}
