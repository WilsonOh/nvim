local M = {
  "nvim-treesitter/nvim-treesitter",
  enabled = true,
  build = ":TSUpdate",
  event = "BufReadPost",
  -- commit = "364b86ec8ea88e4a77ba676b93fb10829d6a9cb3",

  dependencies = {
    "RRethy/nvim-treesitter-endwise",
    -- { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
    -- { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPre", enabled = false },
  },
}

M.config = function()
  -- vim.treesitter.language.register("javascript", "typescriptreact")
  require("nvim-treesitter.configs").setup({
    auto_install = false,
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",
        scope_incremental = "<CR>",
        node_incremental = "<TAB>",
        node_decremental = "<S-TAB>",
      },
    },
    indent = { enable = false },
    highlight = { enable = true },
    endwise = { enable = true },
    -- context_commentstring = { enable = true, enable_autocmd = false },
    playground = { enable = false },
  })
end

return M
