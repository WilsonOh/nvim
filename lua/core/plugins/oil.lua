return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    keymaps = {
      ["q"] = { "actions.close", mode = "n" },
      ["<C-s>"] = { vim.cmd.write },
      ["<C-v>"] = { "actions.select", opts = { vertical = true } },
    },
  },
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  lazy = false,
}
