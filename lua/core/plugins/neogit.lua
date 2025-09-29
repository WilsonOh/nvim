return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "nvim-telescope/telescope.nvim", -- optional
    "sindrets/diffview.nvim", -- optional
    "ibhagwan/fzf-lua", -- optional
  },
  config = function()
    require("neogit").setup({
      integrations = {
        diffview = true,
        snacks = true,
      },
    })
  end,
  cmd = { "Neogit" },
}
