local M = {
  "nvimtools/hydra.nvim",
  enabled = false,
  keys = { "<leader>G" },
}

M.config = function()
  local Hydra = require("hydra")
  local gitsigns = require("gitsigns")

  local hint = [[
^                               Git Mode
^                              ----------
^                _n_: next hunk        _r_: reset hunk
^                _N_: prev hunk        _<Esc>_: exit
^ ^ ^
]]

  Hydra({
    hint = hint,
    config = {
      color = "pink",
      invoke_on_body = true,
      hint = { position = "bottom", float_opts = { border = "rounded" } },
      on_enter = function()
        gitsigns.preview_hunk_inline()
        gitsigns.toggle_linehl(true)
        vim.cmd [[BlameToggle]]
      end,
      on_exit = function()
        gitsigns.toggle_linehl(false)
        vim.cmd [[BlameToggle]]
      end,
    },
    mode = { "n", "x" },
    body = "<leader>G",
    heads = {
      {
        "n",
        function()
          gitsigns.nav_hunk("next")
        end,
      },
      {
        "N",
        function()
          gitsigns.nav_hunk("prev")
        end,
      },
      { "r",     gitsigns.reset_hunk },
      { "<Esc>", nil,                { exit = true, nowait = true } },
    },
  })
end

return M
