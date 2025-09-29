--- @type LazySpec
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  enabled = true,
  ---@type Flash.Config
  opts = {
    search = {
      multi_window = true,
      incremental = true,
      exclude = {
        "toggleterm",
      },
    },
    label = {
      uppercase = false,
    },
    modes = {
      search = {
        enabled = true,
      },
      char = {
        enabled = false,
        jump_labels = true,
        multi_line = false,
      },
    },
  },
}
