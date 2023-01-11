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
  require("nvim-treesitter.configs").setup({
    enabled = true,
    ensure_installed = {
      "cpp",
      "c",
      "lua",
      "rust",
      "python",
      "javascript",
      "typescript",
      "json",
      "html",
      "css",
      "java",
    },
    indent = { enable = false },
    highlight = { enable = true },
    autotag = { enable = true },
    endwise = { enable = true },
    context_commentstring = { enable = true, enable_autocmd = false },
    playground = { enable = true },
  })
end

return M
