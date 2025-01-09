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
  enabled = false,
  config = function()
    require("ccc").setup({
      highlighter = {
        auto_enable = true,
      },
    })
  end,
  ft = filetypes,
}
