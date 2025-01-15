local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
}

M.config = function()
  local wk = require("which-key")
  wk.setup({
    preset = "modern",
  })
  local masterPrefix = "<leader>"
  local keymaps = {
    require("core.which-key.file_keymaps"),
    require("core.which-key.tab_keymaps"),
    require("core.which-key.lazy_keymaps"),
    require("core.which-key.harpoon_keymaps"),
    require("core.which-key.run_file_keymaps"),
    require("core.which-key.noice_keymaps"),
    require("core.which-key.lsp_keymaps"),
  }
  local format_mappings = require("core.which-key.utils").format_keymaps
  for _, keymap in pairs(keymaps) do
    wk.add({ masterPrefix .. keymap.meta.prefix, group = keymap.meta.group })
    wk.add(format_mappings(keymap.mappings, { prefix = masterPrefix .. keymap.meta.prefix }, {}))
  end
end

return M
