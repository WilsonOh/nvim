return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  lazy = false,
  enabled = true,
  config = function()
    local mc = require("multicursor-nvim")

    mc.setup()

    vim.keymap.set({ "n", "v" }, "<C-k>", function() mc.addCursor("k") end)
    vim.keymap.set({ "n", "v" }, "<C-j>", function() mc.addCursor("j") end)

    vim.keymap.set({ "n", "v" }, "<c-n>", function() mc.matchAddCursor(-1) end)
    vim.keymap.set({ "n", "v" }, "<c-N>", function() mc.matchAddCursor(1) end)

    vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)

    vim.keymap.set({ "n", "v" }, "<c-q>", function()
      if mc.cursorsEnabled() then
        mc.disableCursors()
      else
        mc.addCursor()
      end
    end)

    vim.keymap.set("n", "<esc>", function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      elseif mc.hasCursors() then
        mc.clearCursors()
      end
      require("notify").dismiss({
        pending = true,
        silent = true,
      })
      vim.cmd.nohl()
      vim.cmd.nohlsearch()
    end)
  end,
}
