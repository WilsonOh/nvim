local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "BufReadPost",

  dependencies = {
    "windwp/nvim-ts-autotag",
    "RRethy/nvim-treesitter-endwise",
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  },
}

M.config = function()
  vim.treesitter.language.register("javascript", "typescriptreact")
  require("nvim-treesitter.configs").setup({
    enabled = true,
    indent = { enable = false },
    highlight = { enable = true },
    autotag = { enable = true },
    endwise = { enable = true },
    context_commentstring = { enable = true, enable_autocmd = false },
    playground = { enable = true },
  })
end

return M
