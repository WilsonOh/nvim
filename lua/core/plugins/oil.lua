return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true,
    keymaps = {
      ["q"] = { "actions.close", mode = "n" },
      ["<C-s>"] = { vim.cmd.write },
      ["<C-v>"] = { "actions.select", opts = { vertical = true } },
    },
  },
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open up oil.nvim" },
  },
  lazy = false,
}
