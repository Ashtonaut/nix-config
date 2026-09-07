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
      pkgs.vimPlugins.nvim-treesitter
    ]
    ++ (with pkgs.vimPlugins.nvim-treesitter-parsers; [
      astro
      html
      css
      javascript
      typescript
    ]);

    extraPackages = [
      pkgs.lua-language-server
      pkgs.astro-language-server
    ];
  };

  xdg.configFile = {
    "nvim/ftplugin/markdown.lua".source = ./ftplugin/markdown.lua;
    "nvim/plugin/options.lua".source = ./plugin/options.lua;
    "nvim/plugin/lsp.lua".source = ./plugin/lsp.lua;
    "nvim/plugin/treesitter.lua".source = ./plugin/treesitter.lua;

    "nvim/lua/nixpaths.lua".text = ''
      return { 
        hlStubs = "${osConfig.programs.hyprland.package}/share/hypr/stubs",
        tsdk = "${pkgs.typescript}/lib/node_modules/typescript/lib",
        tsQueries = "${pkgs.vimPlugins.nvim-treesitter}/runtime",
      }
    '';
  };
}
