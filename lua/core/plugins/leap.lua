local M = {
  "ggandor/leap.nvim",
  event = "VeryLazy",
  enabled = false,

  dependencies = {
    { "ggandor/flit.nvim", config = { labeled_modes = "nvo", multiline = false } },
  },

  config = function()
    require("leap").add_default_mappings()
    require("leap").opts.highlight_unlabeled_phase_one_targets = true
    vim.keymap.set({ "x", "o" }, "z", "<Plug>(leap-forward-to)")
    vim.keymap.set({ "x", "o" }, "Z", "<Plug>(leap-backward-to)")
  end,
}

return M
