{
  pkgs,
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

    plugins = [ pkgs.vimPlugins.render-markdown-nvim ];
  };

  xdg.configFile = {
    "nvim/ftplugin/markdown.lua".source = ./ftplugin/markdown.lua;
    "nvim/plugin/options.lua".source = ./plugin/options.lua;
  };
}
