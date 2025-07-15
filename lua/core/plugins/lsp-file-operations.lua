return {
  "antosha417/nvim-lsp-file-operations",
  lazy = false,
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-tree.lua",
  },
  config = function()
    require("lsp-file-operations").setup()
  end,
}
