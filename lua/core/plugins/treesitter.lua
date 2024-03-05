local M = {
  "nvim-treesitter/nvim-treesitter",
  enabled = true,
  build = ":TSUpdate",
  event = "BufReadPost",
  -- commit = "364b86ec8ea88e4a77ba676b93fb10829d6a9cb3",

  dependencies = {
    "windwp/nvim-ts-autotag",
    "RRethy/nvim-treesitter-endwise",
    { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  },
}

M.config = function()
  -- vim.treesitter.language.register("javascript", "typescriptreact")
  require("nvim-treesitter.configs").setup({
    enabled = true,
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
    autotag = { enable = true, enable_close_on_slash = false },
    endwise = { enable = true },
    -- context_commentstring = { enable = true, enable_autocmd = false },
    playground = { enable = true },
  })
end

return M
