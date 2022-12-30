return {
  "uga-rosa/ccc.nvim",
  config = function()
    require("ccc").setup({
      highlighter = {
        auto_enable = true,
        filetypes = {
          "html",
          "javascriptreact",
          "typescriptreact",
          "javascript",
          "css",
          "typescript",
          "json",
        },
      },
    })
  end,
  event = "BufReadPre",
}
