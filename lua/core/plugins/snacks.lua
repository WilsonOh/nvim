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
    },
  },
  lazy = false,
}
