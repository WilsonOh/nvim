local M = {
  "ggandor/leap.nvim",
  event = "VeryLazy",
  enabled = false,

  dependencies = {
    { "ggandor/flit.nvim", config = { labeled_modes = "nvo", multiline = false } },
  },

  config = function()
    require("leap").add_default_mappings()
  end,
}

return M
