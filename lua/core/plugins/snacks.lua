return {
  "folke/snacks.nvim",
  opts = {
    --- @type snacks.picker.Config
    picker = {
      enabled = true,
      layout = {
        preset = "telescope",
        fullscreen = true,
      },
      formatters = {
        file = {
          truncate = 80,
        }
      }
    },
  },
  lazy = false,
}
