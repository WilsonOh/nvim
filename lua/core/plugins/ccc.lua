local filetypes = {
  "html",
  "javascriptreact",
  "typescriptreact",
  "javascript",
  "css",
  "typescript",
  "json",
}

return {
  "uga-rosa/ccc.nvim",
  config = function()
    require("ccc").setup({
      highlighter = {
        auto_enable = true,
      },
    })
  end,
  ft = filetypes,
}
