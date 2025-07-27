--[[ return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    search = {
      multi_window = false,
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
        enabled = true,
        jump_labels = true,
        multi_line = false,
      },
    },
  },
} ]]
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {
    ---@type table<string, Flash.Config>
    modes = {
      char = {
        jump_labels = true,
        multi_line = false,
      },
    },
  },
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
  },
}
