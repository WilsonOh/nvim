return {
  "Wansmer/treesj",
  keys = { { "<leader>m", "<cmd>TSJToggle<CR>", { "n" } } },
  config = function()
    require("treesj").setup({
      use_default_keymaps = false,
      max_join_length = 2000,
    })
  end,
}
