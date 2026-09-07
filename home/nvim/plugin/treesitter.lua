vim.opt.runtimepath:append(require("nixpaths").tsQueries)

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "astro", "html", "css", "javascript", "typescript" },
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
